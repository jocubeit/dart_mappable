import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_mappable/dart_mappable.dart';

import '../builder_options.dart';
import '../imports_builder.dart';
import '../utils.dart';
import 'class_mapper_target.dart';
import 'enum_mapper_target.dart';

class MapperTargets {
  final ImportsBuilder imports;
  MapperTargets(AssetId inputId) : imports = ImportsBuilder(inputId);

  Map<ClassElement, EnumMapperTarget> enums = {};
  Map<ClassElement, ClassMapperTarget> classes = {};
  Map<String, ClassElement> customMappers = {};

  void addElementsFromLibrary(LibraryElement library, MappableOptions options) {
    var elements = elementsOf(library);

    for (var element in elements) {
      if (customMapperChecker.hasAnnotationOf(element)) {
        var mapperIndex = element.allSupertypes
            .indexWhere((t) => mapperChecker.isExactlyType(t));
        if (mapperIndex == -1) {
          throw UnsupportedError(
              'Classes marked with @CustomMapper must extend the BaseMapper class');
        }
        var type = element.allSupertypes[mapperIndex].typeArguments[0];
        customMappers[type.element!.name!] = element;
        imports.add(library.source.uri);
        imports.add(type.element!.librarySource!.uri);
      } else if (options.shouldGenerateFor(element) ||
          (!element.isEnum && classChecker.hasAnnotationOf(element)) ||
          (element.isEnum && enumChecker.hasAnnotationOf(element))) {
        addElement(element, options);
        imports.add(library.source.uri);
      }
    }
  }

  void addElement(ClassElement element, MappableOptions options) {
    if (element.isPrivate) return;
    if (element.isEnum) {
      if (enums.containsKey(element)) {
        return;
      }

      enums[element] = EnumMapperTarget(element, options);
      imports.add(element.librarySource.uri);
    } else {
      if (classes.containsKey(element)) {
        return;
      }

      addClassTarget(ClassMapperTarget(element, options));
      imports.add(element.librarySource.uri);

      for (var c in element.constructors) {
        if (c.isFactory &&
            c.redirectedConstructor != null &&
            classChecker.hasAnnotationOf(c)) {
          addClassTarget(FactoryConstructorMapperTarget(c, options));
        }
      }
    }
  }

  void addClassTarget(ClassMapperTarget target) {
    classes[target.element] = target;

    var superElement = target.getSuperElement();
    if (superElement != null) {
      ClassMapperTarget superTarget;
      if (classes.containsKey(superElement)) {
        superTarget = classes[superElement]!;
      } else if (!superElement.isPrivate) {
        addElement(superElement, target.options);
        superTarget = classes[superElement]!;
      } else {
        superTarget = ClassMapperTarget(superElement, target.options);
      }

      target.setSuperTarget(superTarget);
    }
  }

  /// All of the declared classes and enums in this library.
  Iterable<ClassElement> elementsOf(LibraryElement element) sync* {
    for (var cu in element.units) {
      yield* cu.enums;
      yield* cu.classes;
    }
  }
}

abstract class MapperTarget {
  ClassElement element;
  MappableOptions options;
  MapperTarget(this.element, this.options);

  Element get annotatedElement => element;

  late DartObject? annotation = getAnnotation();
  DartObject? getAnnotation();

  String? readAnnotation(String key) =>
      getAnnotationCode(annotatedElement, MappableClass, key);
}

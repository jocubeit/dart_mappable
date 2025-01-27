import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:source_gen/source_gen.dart';

const enumChecker = TypeChecker.fromRuntime(MappableEnum);
const valueChecker = TypeChecker.fromRuntime(MappableValue);
const constructorChecker = TypeChecker.fromRuntime(MappableConstructor);
const classChecker = TypeChecker.fromRuntime(MappableClass);
const fieldChecker = TypeChecker.fromRuntime(MappableField);
const libChecker = TypeChecker.fromRuntime(MappableLib);
const customMapperChecker = TypeChecker.fromRuntime(CustomMapper);
const mapperChecker = TypeChecker.fromRuntime(BaseMapper);

extension GetNode on Element {
  AstNode? getNode() {
    var result = session?.getParsedLibraryByElement(library!);
    if (result is ParsedLibraryResult) {
      return result.getElementDeclaration(this)?.node;
    } else {
      return null;
    }
  }
}

String? getAnnotationCode(
    Element annotatedElement, Type annotationType, dynamic property) {
  var node = annotatedElement.getNode();

  NodeList<Annotation>? annotations;

  if (node is VariableDeclaration) {
    var parent = node.parent?.parent;
    if (parent is FieldDeclaration) {
      annotations = parent.metadata;
    }
  } else if (node is FormalParameter) {
    annotations = node.metadata;
  } else if (node is Declaration) {
    annotations = node.metadata;
  }

  if (annotations == null) {
    print('Unknown node type: ${node.runtimeType} $node');
    return null;
  }

  for (var annotation in annotations) {
    if (annotation.name.name == annotationType.toString()) {
      for (var i = 0; i < annotation.arguments!.arguments.length; i++) {
        var arg = annotation.arguments!.arguments[i];
        if (arg is NamedExpression && property is String) {
          if (arg.name.label.name == property) {
            return arg.expression.toSource();
          }
        } else if (arg is Literal && property is int) {
          if (i == property) {
            return arg.toSource();
          }
        }
      }
    }
  }

  return null;
}

Map<String, T> toMap<T>(dynamic value, T Function(Map m) fn) {
  if (value is Map) {
    return value.map((k, dynamic v) => MapEntry(k as String, fn(v as Map)));
  } else {
    return {};
  }
}

List<T>? toList<T>(dynamic value) {
  if (value is List) {
    return value.map((dynamic v) => v as T).toList();
  } else if (value is T) {
    return [value];
  } else {
    return null;
  }
}

DartObject? fieldAnnotation(ParameterElement param) {
  return fieldChecker.firstAnnotationOf(param) ??
      (param is FieldFormalParameterElement && param.field != null
          ? fieldChecker.firstAnnotationOf(param.field!)
          : null);
}

CaseStyle? caseStyleFromAnnotation(DartObject? obj) {
  return obj != null && !obj.isNull
      ? CaseStyle(
          head: textTransformFromAnnotation(obj.getField('head')!),
          tail: textTransformFromAnnotation(obj.getField('tail')!),
          separator: obj.getField('separator')!.toStringValue() ?? '',
        )
      : null;
}

TextTransform? textTransformFromAnnotation(DartObject obj) {
  var index = obj.getField('index')?.toIntValue();
  return index != null ? TextTransform.values.skip(index).firstOrNull : null;
}

extension NullableType on DartType {
  bool get isNullable => nullabilitySuffix == NullabilitySuffix.question;
}

extension IterableExt<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';

import 'polymorphism_test.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  AnimalMapper._(),
  CatMapper._(),
  DogMapper._(),
  NullAnimalMapper._(),
  DefaultAnimalMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class AnimalMapper extends BaseMapper<Animal> {
  AnimalMapper._();

  @override Function get decoder => decode;
  Animal decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case 'Cat': return CatMapper._().decode(map);
      case 1: return DogMapper._().decode(map);
      case null: return NullAnimalMapper._().decode(map);
      default: return DefaultAnimalMapper._().decode(map);
    }
  });
  Animal fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('Animal', 'type', '${map['type']}');

  @override Function get encoder => (Animal v) => encode(v);
  dynamic encode(Animal v) {
    if (v is Cat) { return CatMapper._().encode(v); }
    else if (v is Dog) { return DogMapper._().encode(v); }
    else if (v is NullAnimal) { return NullAnimalMapper._().encode(v); }
    else if (v is DefaultAnimal) { return DefaultAnimalMapper._().encode(v); }
    else { return toMap(v); }
  }
  Map<String, dynamic> toMap(Animal a) => {'name': Mapper.i.$enc(a.name, 'name')};

  @override String stringify(Animal self) => 'Animal(name: ${Mapper.asString(self.name)})';
  @override int hash(Animal self) => Mapper.hash(self.name);
  @override bool equals(Animal self, Animal other) => Mapper.isEqual(self.name, other.name);

  @override Function get typeFactory => (f) => f<Animal>();
}

extension AnimalMapperExtension  on Animal {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

class CatMapper extends BaseMapper<Cat> {
  CatMapper._();

  @override Function get decoder => decode;
  Cat decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Cat fromMap(Map<String, dynamic> map) => Cat(Mapper.i.$get(map, 'name'), Mapper.i.$get(map, 'color'));

  @override Function get encoder => (Cat v) => encode(v);
  dynamic encode(Cat v) => toMap(v);
  Map<String, dynamic> toMap(Cat c) => {'name': Mapper.i.$enc(c.name, 'name'), 'color': Mapper.i.$enc(c.color, 'color'), 'type': 'Cat'};

  @override String stringify(Cat self) => 'Cat(name: ${Mapper.asString(self.name)}, color: ${Mapper.asString(self.color)})';
  @override int hash(Cat self) => Mapper.hash(self.name) ^ Mapper.hash(self.color);
  @override bool equals(Cat self, Cat other) => Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.color, other.color);

  @override Function get typeFactory => (f) => f<Cat>();
}

extension CatMapperExtension  on Cat {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  CatCopyWith<Cat> get copyWith => CatCopyWith(this, $identity);
}

abstract class CatCopyWith<$R> {
  factory CatCopyWith(Cat value, Then<Cat, $R> then) = _CatCopyWithImpl<$R>;
  $R call({String? name, String? color});
  $R apply(Cat Function(Cat) transform);
}

class _CatCopyWithImpl<$R> extends BaseCopyWith<Cat, $R> implements CatCopyWith<$R> {
  _CatCopyWithImpl(Cat value, Then<Cat, $R> then) : super(value, then);

  @override $R call({String? name, String? color}) => $then(Cat(name ?? $value.name, color ?? $value.color));
}

class DogMapper extends BaseMapper<Dog> {
  DogMapper._();

  @override Function get decoder => decode;
  Dog decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Dog fromMap(Map<String, dynamic> map) => Dog(Mapper.i.$get(map, 'name'), Mapper.i.$get(map, 'age'));

  @override Function get encoder => (Dog v) => encode(v);
  dynamic encode(Dog v) => toMap(v);
  Map<String, dynamic> toMap(Dog d) => {'name': Mapper.i.$enc(d.name, 'name'), 'age': Mapper.i.$enc(d.age, 'age'), 'type': 1};

  @override String stringify(Dog self) => 'Dog(name: ${Mapper.asString(self.name)}, age: ${Mapper.asString(self.age)})';
  @override int hash(Dog self) => Mapper.hash(self.name) ^ Mapper.hash(self.age);
  @override bool equals(Dog self, Dog other) => Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.age, other.age);

  @override Function get typeFactory => (f) => f<Dog>();
}

extension DogMapperExtension  on Dog {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  DogCopyWith<Dog> get copyWith => DogCopyWith(this, $identity);
}

abstract class DogCopyWith<$R> {
  factory DogCopyWith(Dog value, Then<Dog, $R> then) = _DogCopyWithImpl<$R>;
  $R call({String? name, int? age});
  $R apply(Dog Function(Dog) transform);
}

class _DogCopyWithImpl<$R> extends BaseCopyWith<Dog, $R> implements DogCopyWith<$R> {
  _DogCopyWithImpl(Dog value, Then<Dog, $R> then) : super(value, then);

  @override $R call({String? name, int? age}) => $then(Dog(name ?? $value.name, age ?? $value.age));
}

class NullAnimalMapper extends BaseMapper<NullAnimal> {
  NullAnimalMapper._();

  @override Function get decoder => decode;
  NullAnimal decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  NullAnimal fromMap(Map<String, dynamic> map) => NullAnimal(Mapper.i.$get(map, 'name'));

  @override Function get encoder => (NullAnimal v) => encode(v);
  dynamic encode(NullAnimal v) => toMap(v);
  Map<String, dynamic> toMap(NullAnimal n) => {'name': Mapper.i.$enc(n.name, 'name'), 'type': null};

  @override String stringify(NullAnimal self) => 'NullAnimal(name: ${Mapper.asString(self.name)})';
  @override int hash(NullAnimal self) => Mapper.hash(self.name);
  @override bool equals(NullAnimal self, NullAnimal other) => Mapper.isEqual(self.name, other.name);

  @override Function get typeFactory => (f) => f<NullAnimal>();
}

extension NullAnimalMapperExtension  on NullAnimal {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  NullAnimalCopyWith<NullAnimal> get copyWith => NullAnimalCopyWith(this, $identity);
}

abstract class NullAnimalCopyWith<$R> {
  factory NullAnimalCopyWith(NullAnimal value, Then<NullAnimal, $R> then) = _NullAnimalCopyWithImpl<$R>;
  $R call({String? name});
  $R apply(NullAnimal Function(NullAnimal) transform);
}

class _NullAnimalCopyWithImpl<$R> extends BaseCopyWith<NullAnimal, $R> implements NullAnimalCopyWith<$R> {
  _NullAnimalCopyWithImpl(NullAnimal value, Then<NullAnimal, $R> then) : super(value, then);

  @override $R call({String? name}) => $then(NullAnimal(name ?? $value.name));
}

class DefaultAnimalMapper extends BaseMapper<DefaultAnimal> {
  DefaultAnimalMapper._();

  @override Function get decoder => decode;
  DefaultAnimal decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  DefaultAnimal fromMap(Map<String, dynamic> map) => DefaultAnimal(Mapper.i.$get(map, 'name'), Mapper.i.$get(map, 'type'));

  @override Function get encoder => (DefaultAnimal v) => encode(v);
  dynamic encode(DefaultAnimal v) => toMap(v);
  Map<String, dynamic> toMap(DefaultAnimal d) => {'name': Mapper.i.$enc(d.name, 'name'), 'type': Mapper.i.$enc(d.type, 'type')};

  @override String stringify(DefaultAnimal self) => 'DefaultAnimal(name: ${Mapper.asString(self.name)}, type: ${Mapper.asString(self.type)})';
  @override int hash(DefaultAnimal self) => Mapper.hash(self.name) ^ Mapper.hash(self.type);
  @override bool equals(DefaultAnimal self, DefaultAnimal other) => Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.type, other.type);

  @override Function get typeFactory => (f) => f<DefaultAnimal>();
}

extension DefaultAnimalMapperExtension  on DefaultAnimal {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  DefaultAnimalCopyWith<DefaultAnimal> get copyWith => DefaultAnimalCopyWith(this, $identity);
}

abstract class DefaultAnimalCopyWith<$R> {
  factory DefaultAnimalCopyWith(DefaultAnimal value, Then<DefaultAnimal, $R> then) = _DefaultAnimalCopyWithImpl<$R>;
  $R call({String? name, String? type});
  $R apply(DefaultAnimal Function(DefaultAnimal) transform);
}

class _DefaultAnimalCopyWithImpl<$R> extends BaseCopyWith<DefaultAnimal, $R> implements DefaultAnimalCopyWith<$R> {
  _DefaultAnimalCopyWithImpl(DefaultAnimal value, Then<DefaultAnimal, $R> then) : super(value, then);

  @override $R call({String? name, String? type}) => $then(DefaultAnimal(name ?? $value.name, type ?? $value.type));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===




// === GENERATED UTILITY CODE ===

class Mapper {
  Mapper._();

  static MapperContainer i = MapperContainer(_mappers);

  static T fromValue<T>(dynamic value) => i.fromValue<T>(value);
  static T fromMap<T>(Map<String, dynamic> map) => i.fromMap<T>(map);
  static T fromIterable<T>(Iterable<dynamic> iterable) => i.fromIterable<T>(iterable);
  static T fromJson<T>(String json) => i.fromJson<T>(json);

  static dynamic toValue(dynamic value) => i.toValue(value);
  static Map<String, dynamic> toMap(dynamic object) => i.toMap(object);
  static Iterable<dynamic> toIterable(dynamic object) => i.toIterable(object);
  static String toJson(dynamic object) => i.toJson(object);

  static bool isEqual(dynamic value, Object? other) => i.isEqual(value, other);
  static int hash(dynamic value) => i.hash(value);
  static String asString(dynamic value) => i.asString(value);

  static void use<T>(BaseMapper<T> mapper) => i.use<T>(mapper);
  static BaseMapper<T>? unuse<T>() => i.unuse<T>();
  static void useAll(List<BaseMapper> mappers) => i.useAll(mappers);

  static BaseMapper<T>? get<T>([Type? type]) => i.get<T>(type);
  static List<BaseMapper> getAll() => i.getAll();
}

mixin Mappable implements MappableMixin {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);

  @override
  String toString() {
    return _guard(() => Mapper.asString(this), super.toString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            _guard(() => Mapper.isEqual(this, other), () => super == other));
  }

  @override
  int get hashCode {
    return _guard(() => Mapper.hash(this), () => super.hashCode);
  }

  T _guard<T>(T Function() fn, T Function() fallback) {
    try {
      return fn();
    } on MapperException catch (e) {
      if (e.isUnsupportedOrUnallowed()) {
        return fallback();
      } else {
        rethrow;
      }
    }
  }
}

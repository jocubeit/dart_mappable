import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';

import 'primitives_test.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  ItemsMapper._(),
  ItemMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class ItemsMapper extends BaseMapper<Items> {
  ItemsMapper._();

  @override Function get decoder => decode;
  Items decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Items fromMap(Map<String, dynamic> map) => Items(Mapper.i.$get(map, 'items'), Mapper.i.$get(map, 'items2'));

  @override Function get encoder => (Items v) => encode(v);
  dynamic encode(Items v) => toMap(v);
  Map<String, dynamic> toMap(Items i) => {'items': Mapper.i.$enc(i.items, 'items'), 'items2': Mapper.i.$enc(i.items2, 'items2')};

  @override String stringify(Items self) => 'Items(items: ${Mapper.asString(self.items)}, items2: ${Mapper.asString(self.items2)})';
  @override int hash(Items self) => Mapper.hash(self.items) ^ Mapper.hash(self.items2);
  @override bool equals(Items self, Items other) => Mapper.isEqual(self.items, other.items) && Mapper.isEqual(self.items2, other.items2);

  @override Function get typeFactory => (f) => f<Items>();
}

extension ItemsMapperExtension  on Items {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ItemsCopyWith<Items> get copyWith => ItemsCopyWith(this, $identity);
}

abstract class ItemsCopyWith<$R> {
  factory ItemsCopyWith(Items value, Then<Items, $R> then) = _ItemsCopyWithImpl<$R>;
  ListCopyWith<$R, Item, ItemCopyWith<$R>> get items;
  MapCopyWith<$R, int, Item, ItemCopyWith<$R>> get items2;
  $R call({List<Item>? items, Map<int, Item>? items2});
  $R apply(Items Function(Items) transform);
}

class _ItemsCopyWithImpl<$R> extends BaseCopyWith<Items, $R> implements ItemsCopyWith<$R> {
  _ItemsCopyWithImpl(Items value, Then<Items, $R> then) : super(value, then);

  @override ListCopyWith<$R, Item, ItemCopyWith<$R>> get items => ListCopyWith($value.items, (v, t) => ItemCopyWith(v, t), (v) => call(items: v));
  @override MapCopyWith<$R, int, Item, ItemCopyWith<$R>> get items2 => MapCopyWith($value.items2, (v, t) => ItemCopyWith(v, t), (v) => call(items2: v));
  @override $R call({List<Item>? items, Map<int, Item>? items2}) => $then(Items(items ?? $value.items, items2 ?? $value.items2));
}

class ItemMapper extends BaseMapper<Item> {
  ItemMapper._();

  @override Function get decoder => decode;
  Item decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Item fromMap(Map<String, dynamic> map) => Item(Mapper.i.$get(map, 'index'));

  @override Function get encoder => (Item v) => encode(v);
  dynamic encode(Item v) => toMap(v);
  Map<String, dynamic> toMap(Item i) => {'index': Mapper.i.$enc(i.index, 'index')};

  @override String stringify(Item self) => 'Item(index: ${Mapper.asString(self.index)})';
  @override int hash(Item self) => Mapper.hash(self.index);
  @override bool equals(Item self, Item other) => Mapper.isEqual(self.index, other.index);

  @override Function get typeFactory => (f) => f<Item>();
}

extension ItemMapperExtension  on Item {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ItemCopyWith<Item> get copyWith => ItemCopyWith(this, $identity);
}

abstract class ItemCopyWith<$R> {
  factory ItemCopyWith(Item value, Then<Item, $R> then) = _ItemCopyWithImpl<$R>;
  $R call({int? index});
  $R apply(Item Function(Item) transform);
}

class _ItemCopyWithImpl<$R> extends BaseCopyWith<Item, $R> implements ItemCopyWith<$R> {
  _ItemCopyWithImpl(Item value, Then<Item, $R> then) : super(value, then);

  @override $R call({int? index}) => $then(Item(index ?? $value.index));
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

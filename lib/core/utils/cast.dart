// ignore_for_file: type=lint

extension StringExtension on String? {
  // provide empty value when optional string
  String get safe => this ?? '';
}

extension IntExtension on int? {
  // provide empty value when optional int
  int get safe => this ?? 0;
}

extension DoubleExtension on double? {
  // provide empty value when optional double
  double get safe => this ?? 0.0;
}

extension BoolExtension on bool? {
  // provide empty value when optional bool
  bool get safe => this ?? false;
}

extension ListExtension on List? {
  // provide empty value when optional list
  List<dynamic> get safe => this ?? [];
}

extension MapExtension on Map<dynamic, dynamic>? {
  // provide empty value when optional map
  Map<dynamic, dynamic> get safe => this ?? {};
}

extension SetExtension on Set<dynamic>? {
  // provide empty value when optional set
  Set<dynamic> get safe => this ?? {};
}

T? tryCast<T>(dynamic object) => object is T ? object : null;
T safeCastString<T extends String>(dynamic object) => object is T ? object : '' as T;
T safeCastInt<T extends int>(dynamic object) => object is T ? object : 0 as T;
T safeCastDouble<T extends double>(dynamic object) => object is T ? object : 0.0 as T;
T safeCastBool<T extends bool>(dynamic object) => object is T ? object : false as T;
T safeCastList<T extends List<dynamic>>(dynamic object) => object is T ? object : [] as T;
T safeCastMap<T extends Map<dynamic, dynamic>>(dynamic object) => object is T ? object : {} as T;
T safeCastSet<T extends Set<dynamic>>(dynamic object) => object is T ? object : {} as T;
T safeCast<T>(dynamic object, T Function(dynamic) cast) => object is T ? object : cast(object);

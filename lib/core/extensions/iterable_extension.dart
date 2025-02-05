extension IterableExtension<E> on Iterable<E>? {
  bool get listIsEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }

  bool get listIsNotEmpty {
    if (this == null) return false;
    return this!.isNotEmpty;
  }
}

extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this list with name [name].
  ///
  /// Modified from [byName] in [EnumByName] from enum.dart in dart:core
  /// Goes through this collection looking for an enum with
  /// name [name], as reported by [EnumName.name].
  /// Returns the first value with the given name, or null if not found
  T? byNameOrNull(String? name) {
    if (name == null) return null;
    for (var value in this) {
      if (value.name == name) return value;
    }
    // Used to throw ArgumentError now returns null
    return null;
  }
}

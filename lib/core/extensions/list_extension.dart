extension ListExtension<T> on List<T> {
  T? get(int index) {
    final result = this[index];
    return result;
  }
}

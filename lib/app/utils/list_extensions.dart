extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndex<T>(T f(E e, int i)) {
    int i = 0;
    // ignore: always_specify_types
    return map((e) => f(e, i++));
  }

  void forEachIndex(void f(E e, int i)) {
    int i = 0;
    // ignore: always_specify_types
    forEach((e) => f(e, i++));
  }
}
class Result<T> {
  final T? val;
  final String? error;

  Result({this.val, this.error});

  bool get hasError => error != null;
}

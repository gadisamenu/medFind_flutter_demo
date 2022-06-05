class Return<T, String> {
  T? value;
  String? error;

  Return({this.value, this.error});

  bool get hasError => error != null;
}

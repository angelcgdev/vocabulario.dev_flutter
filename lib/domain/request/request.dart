class RequestData<T> {
  String domain;
  String? path;
  T? data;
  Map<String, String>? headers;
  Map<String, String>? parameters;
  RequestData(
      {required this.domain,
      this.path,
      this.data,
      this.headers,
      this.parameters});
}

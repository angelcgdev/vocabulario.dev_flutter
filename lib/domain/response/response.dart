class ResponseData<T> {
  T data;
  int? statusCode = 200;
  ResponseData({required this.data, this.statusCode});
}

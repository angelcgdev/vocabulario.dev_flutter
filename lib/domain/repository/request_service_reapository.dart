import 'package:vocabulario_dev/domain/request/request.dart';
import 'package:vocabulario_dev/domain/response/response.dart';

abstract class RequestServiceRepositoryInterface {
  Future<ResponseData> get(RequestData requestData);
  Future<ResponseData> post(RequestData requestData);
}

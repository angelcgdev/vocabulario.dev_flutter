import 'package:vocabulario_dev/modules/common/domain/request/request.dart';
import 'package:vocabulario_dev/modules/common/domain/response/response.dart';

abstract class RequestServiceRepositoryInterface {
  Future<ResponseData> get(RequestData requestData);
  Future<ResponseData> post(RequestData requestData);
  Future<ResponseData> put(RequestData requestData);
  Future<ResponseData> delete(RequestData requestData);
}

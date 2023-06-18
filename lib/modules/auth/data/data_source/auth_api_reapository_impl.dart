import 'dart:convert';

import 'package:vocabulario_dev/modules/auth/data/exceptions/auth_exception.dart';
import 'package:vocabulario_dev/modules/home/data/exceptions/request_exception.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/request/request.dart';
import 'package:vocabulario_dev/modules/auth/domain/response/signin_request.dart';
import 'package:vocabulario_dev/modules/auth/domain/response/login_response.dart';
import 'package:vocabulario_dev/modules/auth/domain/request/login_request.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/api.dart';

class AuthApiReapositoryImpl extends AuthApiReapositoryInterface {
  final RequestServiceRepositoryInterface _requestService;
  AuthApiReapositoryImpl(
      {required RequestServiceRepositoryInterface requestService})
      : _requestService = requestService;

  @override
  Future<LoginResponse> refreshSesion(String token) async {
    try {
      final request = await _requestService.post(RequestData(
          domain: Api.domain,
          path: '/api/auth/refresh',
          data: {"token": token}));
      if (request.data != null) {
        final dataDecoded = jsonDecode(request.data);
        if (request.statusCode == 200) {
          final response = LoginResponse.fromJson(dataDecoded);
          return response;
        }
        if (dataDecoded is List) throw AuthException(dataDecoded[0]['msg']);

        throw AuthException(dataDecoded['msg']);
      }
      throw const AuthException('something went wrong');
    } on RequestException catch (e) {
      throw AuthException(e.cause);
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest loginData) async {
    try {
      final request = await _requestService.post(RequestData(
          domain: Api.domain,
          path: '/api/auth/login',
          data: loginData.toJson()));
      if (request.data != null) {
        print(request.data);
        final dataDecoded = jsonDecode(request.data);
        if (request.statusCode == 200) {
          final response = LoginResponse.fromJson(dataDecoded);
          return response;
        }
        if (dataDecoded is List) throw AuthException(dataDecoded[0]['msg']);

        throw AuthException(dataDecoded['msg']);
      }
      throw const AuthException('something went wrong');
    } on RequestException catch (e) {
      throw AuthException(e.cause);
    }
  }

  @override
  Future<void> logout(String token) async {
    return;
  }

  @override
  Future<LoginResponse> signin(SignInRequest signinData) async {
    try {
      final request = await _requestService.post(
        RequestData(
          domain: Api.domain,
          path: '/api/auth/signin',
          data: signinData.toJson(),
        ),
      );
      if (request.data != null) {
        final dataDecoded = jsonDecode(request.data);
        if (request.statusCode == 201) {
          final response = LoginResponse.fromJson(dataDecoded);
          return response;
        }
        if (dataDecoded is List) throw AuthException(dataDecoded[0]['msg']);

        throw AuthException(dataDecoded['msg']);
      }
      throw const AuthException('something went wrong');
    } on RequestException catch (e) {
      throw AuthException(e.cause);
    }
  }
}

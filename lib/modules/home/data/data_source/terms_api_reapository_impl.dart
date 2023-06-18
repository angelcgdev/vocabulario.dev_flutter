import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/api.dart';
import 'package:vocabulario_dev/modules/home/data/exceptions/request_exception.dart';
import 'package:vocabulario_dev/modules/home/data/exceptions/term_expeption.dart';
import 'package:vocabulario_dev/modules/home/domain/model/term.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/terms_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/domain/request/complete_request.dart';
import 'package:vocabulario_dev/modules/common/domain/request/request.dart';

class TermsApiReapositoryImpl implements TermsApiReapositoryInterface {
  final RequestServiceRepositoryInterface _requestService;
  final UserInfoStorageReapositoryInterface _userInfo;
  TermsApiReapositoryImpl({
    required RequestServiceRepositoryInterface requestService,
    required UserInfoStorageReapositoryInterface userInfo,
  })  : _userInfo = userInfo,
        _requestService = requestService;
  @override
  Future<List<Term>> getTermByLessonId(int id) async {
    try {
      final token = await _userInfo.getToken();
      final headers = {"Content-Type": "application/json", "token": token!};
      final request = await _requestService.get(RequestData(
          domain: Api.domain,
          path: '/api/terms/',
          headers: headers,
          parameters: {'lessonId': '$id'}));
      if (request.statusCode == 200) {
        final dataDecoded = jsonDecode(request.data)['data'] as List;
        return dataDecoded.map((e) => Term.fromJson(e)).toList();
      }
      throw ErrorDescription(request.data);
    } on RequestException catch (e) {
      throw ErrorDescription(e.cause);
    }
  }

  @override
  Future<void> toComplete(CompleteRequest data) async {
    try {
      final token = await _userInfo.getToken();
      final headers = {"Content-Type": "application/json", "token": token!};
      final request = await _requestService.post(
        RequestData(
          domain: Api.domain,
          path: '/api/terms/completed',
          headers: headers,
          data: data.toJson(),
        ),
      );
      if (request.statusCode == 200) return;
      if (request.data != null) {
        final jsonDecoded = jsonDecode(request.data);
        if (jsonDecoded is List) {
          throw TermException(jsonDecoded[0]['msg']);
        }
        throw TermException(jsonDecoded['msg'] ?? 'something went wrong.');
      }
      throw TermException('something went wrong.');
    } on RequestException catch (e) {
      throw TermException(e.cause);
    }
  }
}

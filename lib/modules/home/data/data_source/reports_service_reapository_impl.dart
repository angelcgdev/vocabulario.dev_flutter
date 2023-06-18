import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/api.dart';
import 'package:vocabulario_dev/modules/home/domain/model/report.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/reports_api_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/request/request.dart';

class ReportsServiceReapositoryImpl implements ReportsApiRepositoryInterface {
  final RequestServiceRepositoryInterface _requestService;
  final UserInfoStorageReapositoryInterface _userInfo;
  ReportsServiceReapositoryImpl(
      {required RequestServiceRepositoryInterface requestService,
      required UserInfoStorageReapositoryInterface userInfo})
      : _userInfo = userInfo,
        _requestService = requestService;

  @override
  Future<List<Report>> getReporsListByUserId(int userId) async {
    try {
      final token = await _userInfo.getToken();
      final request = await _requestService.get(RequestData(
          domain: Api.domain,
          path: '/api/reports',
          headers: {'token': token!},
          parameters: {'userId': userId.toString()}));
      final reports = json.decode(request.data)['data'] as List;
      return reports.map((e) => Report.fromJson(e)).toList();
    } catch (e) {
      throw ErrorDescription('something went wrong');
    }
  }

  @override
  Future<List<Report>> getReporsList() async {
    try {
      final token = await _userInfo.getToken();
      final request = await _requestService.get(RequestData(
        domain: Api.domain,
        path: '/api/reports',
        headers: {'token': token!},
      ));
      final reports = json.decode(request.data)['data'] as List;
      return reports.map((e) => Report.fromJson(e)).toList();
    } catch (e) {
      throw ErrorDescription('something went wrong');
    }
  }

  @override
  Future<void> create(Report report) async {
    try {
      final token = await _userInfo.getToken();
      final headers = {"Content-Type": "application/json", "token": token!};
      final request = await _requestService.post(
        RequestData(
          domain: Api.domain,
          path: '/api/reports/',
          headers: headers,
          data: report.toJson(),
        ),
      );
      if (request.statusCode != 201) {
        throw ErrorDescription(request.data);
      }
    } catch (e) {
      throw ErrorDescription('something went wrong');
    }
  }
}

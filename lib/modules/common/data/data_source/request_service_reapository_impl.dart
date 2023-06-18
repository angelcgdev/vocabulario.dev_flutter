import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/data/exceptions/request_exception.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/response/response.dart';
import 'package:vocabulario_dev/modules/common/domain/request/request.dart';
import 'package:http/http.dart' as http;

class RequestServiceReapositoryImpl
    implements RequestServiceRepositoryInterface {
  @override
  Future<ResponseData> get(RequestData requestData) async {
    try {
      final domain = requestData.domain;
      final path = requestData.path;
      final uri = Uri.https(domain, path ?? '', requestData.parameters);
      final headers = {
        "Content-Type": "application/json",
        ...?requestData.headers
      };
      final request = await http.get(
        uri,
        headers: headers,
      );
      return ResponseData<String>(
          data: request.body, statusCode: request.statusCode);
    } catch (e) {
      debugPrint('$e');
      throw const RequestException('something went wrong');
    }
  }

  @override
  Future<ResponseData> post(RequestData requestData) async {
    try {
      final domain = requestData.domain;
      debugPrint('==========>domain');
      debugPrint(domain);
      final path = requestData.path;
      final uri = Uri.https(domain, path ?? '');
      debugPrint('==========>url');
      debugPrint(uri.toString());
      final headers = {
        "Content-Type": "application/json",
        ...?requestData.headers
      };
      final request = await http.post(uri,
          headers: headers, body: jsonEncode(requestData.data));
      return ResponseData(data: request.body, statusCode: request.statusCode);
    } catch (e) {
      throw const RequestException('something went wrong');
    }
  }
}

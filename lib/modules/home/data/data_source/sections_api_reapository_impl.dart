import 'dart:convert';

import 'package:vocabulario_dev/modules/home/data/exceptions/section_exception.dart';
import 'package:vocabulario_dev/modules/home/domain/model/section.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/sections_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/request/request.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/api.dart';

class SectionsApiReapositoryImpl implements SectionsApiReapositoryInterface {
  RequestServiceRepositoryInterface requestService;
  UserInfoStorageReapositoryInterface userInfosecureStorage;
  SectionsApiReapositoryImpl(
      {required this.requestService, required this.userInfosecureStorage});

  @override
  Future<List<Section>> getSectionsListWithProgress(int userId) async {
    final token = await userInfosecureStorage.getToken();
    final request = await requestService.get(RequestData(
      domain: Api.domain,
      path: '/api/sections/progress/$userId',
      headers: {'token': token ?? ''},
    ));
    final data = request.data;
    if (data != null) {
      final dataDecoded = jsonDecode(data);
      if (request.statusCode == 200) {
        final sections = dataDecoded['data'] as List;
        return sections.map((e) => Section.fromJson(e)).toList();
      }
      if (dataDecoded is List) throw SectionException(dataDecoded[0]['msg']);

      throw SectionException(dataDecoded['msg']);
    }
    throw const SectionException('something went wrong');
  }
}

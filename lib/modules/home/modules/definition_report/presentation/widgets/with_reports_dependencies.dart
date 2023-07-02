import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/home/data/data_source/reports_service_reapository_impl.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/reports_api_reapository.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/aplication/reports_bloc.dart';

class WithReportsDependencies extends StatelessWidget {
  const WithReportsDependencies({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ReportsApiRepositoryInterface>(
      create: (context) => ReportsServiceReapositoryImpl(
        requestService:
            RepositoryProvider.of<RequestServiceRepositoryInterface>(context),
        userInfo:
            RepositoryProvider.of<UserInfoStorageReapositoryInterface>(context),
      ),
      child: BlocProvider(
        create: (context) => ReportsBloc(
          reportReapository:
              RepositoryProvider.of<ReportsApiRepositoryInterface>(context),
        ),
        child: Builder(builder: builder),
      ),
    );
  }
}

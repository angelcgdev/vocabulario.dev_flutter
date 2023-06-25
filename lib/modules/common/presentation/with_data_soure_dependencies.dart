import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/request_service_reapository_impl.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/secure_storage_reapository_impl.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';

class WithBasicDataSourceDependencies extends StatelessWidget {
  const WithBasicDataSourceDependencies({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<RequestServiceRepositoryInterface>(
          create: (_) => RequestServiceReapositoryImpl(),
        ),
        RepositoryProvider<SecureStorageReapositoryInterface>(
          create: (_) => SecureStorageReapositoryImpl(),
        ),
      ],
      child: Builder(
        builder: builder,
      ),
    );
  }
}
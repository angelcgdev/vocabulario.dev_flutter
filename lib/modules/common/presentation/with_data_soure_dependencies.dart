import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/request_service_reapository_impl.dart';
import 'package:vocabulario_dev/modules/common/data/data_source/secure_storage_reapository_impl.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';

class WithBasicDataSourceDependencies extends StatelessWidget {
  const WithBasicDataSourceDependencies({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RequestServiceRepositoryInterface>(
          create: (_) => RequestServiceReapositoryImpl(),
        ),
        Provider<SecureStorageReapositoryInterface>(
          create: (_) => SecureStorageReapositoryImpl(),
        ),
      ],
      child: Builder(
        builder: builder,
      ),
    );
  }
}
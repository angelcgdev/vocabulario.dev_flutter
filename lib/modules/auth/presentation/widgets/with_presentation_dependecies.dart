import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/auth/data/data_source/auth_api_reapository_impl.dart';
import 'package:vocabulario_dev/modules/auth/data/data_source/userinfo_storage_reapository_impl.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';

class WithPresentationDependencies extends StatelessWidget {
  const WithPresentationDependencies({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            Provider<AuthApiReapositoryInterface>(
              create: (_) => AuthApiReapositoryImpl(
                  requestService:
                      context.read<RequestServiceRepositoryInterface>()),
            ),
            Provider<UserInfoStorageReapositoryInterface>(
              create: (_) => UserInfoStorageReapositoryImpl(
                  secureStorage:
                      context.read<SecureStorageReapositoryInterface>()),
            ),
          ],
          child: Builder(
            builder: builder
          ),
        );
  }
}
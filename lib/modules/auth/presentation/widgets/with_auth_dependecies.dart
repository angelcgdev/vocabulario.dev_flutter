import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/aplication/login_bloc.dart';
import 'package:vocabulario_dev/modules/auth/aplication/login_state.dart';
import 'package:vocabulario_dev/modules/auth/data/data_source/auth_api_reapository_impl.dart';
import 'package:vocabulario_dev/modules/auth/data/data_source/userinfo_storage_reapository_impl.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';

class WithAuthDependencies extends StatelessWidget {
  const WithAuthDependencies({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthApiReapositoryInterface>(
          create: (_) => AuthApiReapositoryImpl(
              requestService: RepositoryProvider.of<RequestServiceRepositoryInterface>(context),
            ),
        ),
        RepositoryProvider<UserInfoStorageReapositoryInterface>(
          create: (_) => UserInfoStorageReapositoryImpl(
              secureStorage: RepositoryProvider.of<SecureStorageReapositoryInterface>(context),
            ),
        ),
      ],
      child: BlocProvider(
        create: (context) => LoginBloc(
          initialState: LoginInitial(),
          authReapository: RepositoryProvider.of<AuthApiReapositoryInterface>(context),
          userInfoReapository: RepositoryProvider.of<UserInfoStorageReapositoryInterface>(context),
        ),
        child: Builder(
          builder: builder
        ),
      ),
    );
  }
}
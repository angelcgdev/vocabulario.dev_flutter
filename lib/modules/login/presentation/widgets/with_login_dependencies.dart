import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/login/aplication/login_bloc.dart';

class WithLoginDependencies extends StatelessWidget {
  const WithLoginDependencies({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>LoginBloc(
        authReapository: RepositoryProvider.of<AuthApiReapositoryInterface>(context),
        userReapository: RepositoryProvider.of<UserInfoStorageReapositoryInterface>(context),
      ),
      child: Builder(builder: builder),
    );
  }
}
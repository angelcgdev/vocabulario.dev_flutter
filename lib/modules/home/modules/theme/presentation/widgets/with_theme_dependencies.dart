import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/aplication/theme_bloc.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/data/data_source/local/theme_local_data_src.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/data/data_source/theme_repository_impl.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/reapository/theme_reapository.dart';

class WithThemeDependencies extends StatelessWidget {
  const WithThemeDependencies({super.key, required this.builder});
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ThemeReapositoryInterface>(
      create: (context) => ThemeReapositoryImpl(
        themeDataSource: ThemeLocalDataSrc(
          storage:
              RepositoryProvider.of<SecureStorageReapositoryInterface>(context),
        ),
      ),
      child: BlocProvider(
        create: (context) {
          return ThemeBloc(
            themeReapository:
                RepositoryProvider.of<ThemeReapositoryInterface>(context),
          );
        },
        child: Builder(
          builder: builder,
        ),
      ),
    );
  }
}

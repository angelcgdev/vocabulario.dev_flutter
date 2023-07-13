import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/home/data/data_source/terms_api_reapository_impl.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/terms_api_reapository.dart';
import 'package:vocabulario_dev/modules/home/modules/lesson/aplication/lesson_bloc.dart';

class WithLessonDependencies extends StatelessWidget {
  const WithLessonDependencies({
    super.key,
    required this.builder,
  });
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TermsApiReapositoryInterface>(
      create: (context) {
        return TermsApiReapositoryImpl(
          requestService:
              RepositoryProvider.of<RequestServiceRepositoryInterface>(context),
          userInfo: RepositoryProvider.of<UserInfoStorageReapositoryInterface>(
              context),
        );
      },
      child: BlocProvider(
        create: (context) {
          return LessonBloc(
            termsRepository:
                RepositoryProvider.of<TermsApiReapositoryInterface>(context),
          );
        },
        child: Builder(
          builder: builder,
        ),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vocabulario_dev/modules/common/widgets/async_btn.dart';
import 'package:vocabulario_dev/modules/home/domain/model/term.dart';
import 'package:vocabulario_dev/modules/home/domain/model/lesson.dart';
import 'package:vocabulario_dev/modules/home/modules/lesson/aplication/lesson_bloc.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/lesson/widget/report_term_dialog.dart';
import 'package:vocabulario_dev/modules/common/widgets/loading_layout.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/lesson/with_lesson_dependencies.dart';

class LessonPage extends StatelessWidget {
  const LessonPage._();
  static Widget init(BuildContext context) {
    return WithLessonDependencies(
      builder: (context) {
        return const LessonPage._();
      },
    );
  }

  static String path = '/home/lesson';

  @override
  Widget build(BuildContext context) {
    final lessonBloc = BlocProvider.of<LessonBloc>(context, listen: false);
    final lesson = ModalRoute.of(context)?.settings.arguments as Lesson?;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      lessonBloc.add(LessonSelected(lesson!));
    });
    if (lesson == null) {
      return const SizedBox.shrink();
    }
    return _BodyWithTerm(lesson: lesson);
  }
}

class _BodyWithTerm extends StatefulWidget {
  const _BodyWithTerm({
    required this.lesson,
  });

  final Lesson lesson;

  @override
  State<_BodyWithTerm> createState() => _BodyWithTermState();
}

class _BodyWithTermState extends State<_BodyWithTerm>
    with TickerProviderStateMixin {
  // late LessonController controller;
  late PageController pageController;

  @override
  void initState() {
    // controller = context.read<LessonController>();
    final lastTermCompletedIndex =
        widget.lesson.terms.lastIndexWhere((element) => element.completed);
    pageController = PageController(initialPage: lastTermCompletedIndex + 1);
    init();
    super.initState();
  }

  init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // controller.getTermsByLessonid(widget.lesson.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalTerms = widget.lesson.terms.length;
    final completedTerms =
        widget.lesson.terms.takeWhile((p) => p.completed).length;
    final calc = completedTerms / totalTerms;
    double progress = calc.isNaN ? 0 : calc * 100;
    final localization = AppLocalizations.of(context)!;
    final nroOfTerms = widget.lesson.terms.length;
    // return Selector<LessonController, bool>(
    //     selector: (_, controller) => controller.isLoading,
    //     shouldRebuild: (pre, next) {
    //       final error = controller.error;
    //       if (error != null) {
    //         final snackbError = SnackBar(
    //           content: Text(
    //             error,
    //             style: theme.textTheme.bodySmall
    //                 ?.copyWith(color: theme.colorScheme.onError),
    //           ),
    //           backgroundColor: theme.colorScheme.error,
    //         );
    //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //           ScaffoldMessenger.of(context).showSnackBar(snackbError);
    //         });
    //       }
    //       return pre != next;
    //     },
    //     builder: (_, ___, __) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.name),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return ReportTermDialog(
                      parentcontext: context,
                    );
                  });
            },
            icon: const Icon(
              FeatherIcons.alertTriangle,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize:
              const Size(double.infinity, (DefaultTheme.padding * 2) + 5),
          child: Padding(
            padding: const EdgeInsets.all(DefaultTheme.padding),
            child: LinearProgressIndicator(
              value: progress / 100,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultTheme.padding),
        child: ElevateButtonAsyn(
          onPressed: () {
            final navigator = Navigator.of(context);
            final currentIndex = pageController.page!.round();
            final normalizedIndex = currentIndex + 1;
            if (normalizedIndex < nroOfTerms) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut,
              );
              return;
            }
            return navigator.pop();
          },
          isLoading: false,
          label: Text(localization.lesson_page_btn_continue),
        ),
      ),
      // persistentFooterButtons: [
      //   // ElevateButtonAsyn(
      //   //   onPressed: () async {
      //   //     final navigator = Navigator.of(context);
      //   //     final currentIndex = pageController.page!.round();
      //   //     // final normalizedIndex = currentIndex + 1;
      //   //     // await controller.toComplete();
      //   //     // if (controller.error != null) return;

      //   //     // if (normalizedIndex < nroOfTerms) {
      //   //     //   pageController.nextPage(
      //   //     //     duration: const Duration(milliseconds: 300),
      //   //     //     curve: Curves.bounceInOut,
      //   //     //   );
      //   //     //   return;
      //   //     // }
      //   //     // return navigator.pop();
      //   //   },
      //   //   isLoading: true,
      //   //   label: Text(localization.lesson_page_btn_continue),
      //   // ),
      //   ElevateButtonAsyn(
      //     onPressed: () {
      //       final navigator = Navigator.of(context);
      //       final currentIndex = pageController.page!.round();
      //       final normalizedIndex = currentIndex + 1;
      //     },
      //     isLoading: false,
      //     label: Text(localization.lesson_page_btn_continue),
      //   ),
      // ],
      body: BlocConsumer<LessonBloc, LessonState>(listener: (context, state) {
        final overlay = LoadingOverlay.of(context);
        if (state.status == LessonStatus.loading) return overlay.show();
        return overlay.hide();
      }, builder: (_, state) {
        if (state.terms.isEmpty) {
          return const Center(
            child: Text('there is not any term'),
          );
        }
        return PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: state.terms.map((e) => _TermView(term: e)).toList(),
        );
      }),
    );
    // });
  }
}

class _TermView extends StatelessWidget {
  const _TermView({
    required this.term,
  });

  final Term term;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
      color: theme.primaryColor.withOpacity(.1),
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: DefaultTheme.padding * .5,
              right: DefaultTheme.padding * .5,
              top: DefaultTheme.padding,
            ),
            child: Container(
              padding: const EdgeInsets.all(DefaultTheme.padding * .5),
              decoration: containerDecoration,
              child: Text(
                term.title,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(
            height: DefaultTheme.gap,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: DefaultTheme.padding * .5,
              right: DefaultTheme.padding * .5,
              bottom: DefaultTheme.padding,
            ),
            child: Container(
              padding: const EdgeInsets.all(DefaultTheme.padding * .5),
              decoration: containerDecoration,
              child: Text(term.content),
            ),
          )
        ],
      ),
    );
  }
}

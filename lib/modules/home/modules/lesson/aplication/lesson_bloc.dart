import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/home/domain/model/lesson.dart';
import 'package:vocabulario_dev/modules/home/domain/model/term.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/terms_api_reapository.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final TermsApiReapositoryInterface _termsRepository;
  LessonBloc({required TermsApiReapositoryInterface termsRepository}) : _termsRepository = termsRepository, super(const LessonState()) {
    on<LessonSelected>(_onLessonSelected);
  }
  void _onLessonSelected(LessonSelected event,Emitter<LessonState> emit)async{
      emit(state.copyWith(status: LessonStatus.loading));
      try {
        final terms = await _termsRepository.getTermByLessonId(event.lesson.id);
        debugPrint('hola ${terms.length}');
        emit(state.copyWith(status: LessonStatus.success, terms: terms));
        print('estado emitido');
      } catch (e) {
        emit(state.copyWith(status: LessonStatus.failure));
      }
  }
}

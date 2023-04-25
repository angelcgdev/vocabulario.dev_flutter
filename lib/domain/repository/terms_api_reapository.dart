import 'package:vocabulario_dev/domain/model/term.dart';
import 'package:vocabulario_dev/domain/request/complete_request.dart';

abstract class TermsApiReapositoryInterface {
  Future<List<Term>> getTermByLessonId(int id);
  Future<void> toComplete(CompleteRequest data);
}

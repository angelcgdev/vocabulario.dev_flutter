
import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/data/exceptions/term_expeption.dart';
import 'package:vocabulario_dev/modules/home/domain/model/lesson.dart';
import 'package:vocabulario_dev/modules/home/domain/model/term.dart';
import 'package:vocabulario_dev/modules/home/domain/model/report.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/reports_api_reapository.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/terms_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/domain/request/complete_request.dart';

class LessonController extends ChangeNotifier {
  final ReportsApiRepositoryInterface _reportsService;
  final TermsApiReapositoryInterface _termService;
  final UserInfoStorageReapositoryInterface _userInfo;
  LessonController({
    required ReportsApiRepositoryInterface reportsService,
    required UserInfoStorageReapositoryInterface userInfo,
    required TermsApiReapositoryInterface termsService,
  })  : _reportsService = reportsService,
        _userInfo = userInfo,
        _termService = termsService;

  List<Term> _terms = [];
  Lesson? _lesson;
  Lesson? get lesson => _lesson;
  set lesson(Lesson? value) {
    _lesson = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get loading => _isLoading;
  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? _error;
  int _currentTermIndex = 0;
  set currentTermIndex(index) {
    _currentTermIndex = index;
  }

  String? get error => _error;
  bool isLoading = true;
  List<Term> get terms => _terms;

  Future<void> getTermsByLessonid(int lessonid) async {
    isLoading = true;
    notifyListeners();
    try {
      final request = await _termService.getTermByLessonId(lessonid);
      _terms = request;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toComplete() async {
    try {
      _error = null;
      isLoading = true;
      final user = await _userInfo.getUser();
      await _termService.toComplete(
          CompleteRequest(termId: _currentTermIndex, userId: user!.id));
      toCompleteLocaly();
    } on TermException catch (e) {
      _error = e.cause;
      notifyListeners();
    } finally {
      isLoading = false;
    }
  }

  void toCompleteLocaly() {
    final termIndex =
        lesson?.terms.indexWhere((e) => e.id == _currentTermIndex);
    if (termIndex == null) return;
    final term = lesson!.terms[termIndex];
    final listProgress = [...lesson!.terms];
    listProgress[termIndex] = Progress(id: term.id, completed: true);
    final newLesson = lesson;
    newLesson?.terms = listProgress;
    lesson = newLesson;
  }

  Future<void> reportTerm(
      {required int idLesson,
      required String description,
      required bool isCorrect}) async {
    final user = await _userInfo.getUser();
    final report = Report(
        id: 1,
        userId: user!.id,
        isCorrect: isCorrect,
        lessonId: 1,
        description: 'test');
    await _reportsService.create(report);
  }
}

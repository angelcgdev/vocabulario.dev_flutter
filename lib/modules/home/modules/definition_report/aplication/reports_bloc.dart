import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/reports_api_reapository.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/domain/model/models.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsApiRepositoryInterface reportReapository;
  ReportsBloc({required this.reportReapository}) : super(const ReportsState()) {
    on<ReportsFetched>(_onPostFetched);
  }

  void _onPostFetched(ReportsFetched event, Emitter<ReportsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ReportStatus.initial) {
        final reports = await reportReapository.getReporsList();
        return emit(state.copyWith(
          status: ReportStatus.success,
          reports: reports,
          hasReachedMax: false,
        ));
      }
      final posts = await reportReapository.getReporsList();
      if(posts.isEmpty) return emit(state.copyWith(hasReachedMax: true));
      return emit(
              state.copyWith(
                status: ReportStatus.success,
                reports: List.of(state.reports)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (e) {
      emit(state.copyWith(status: ReportStatus.failure));
    }
  }
}

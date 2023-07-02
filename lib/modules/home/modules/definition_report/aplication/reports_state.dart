part of 'reports_bloc.dart';

enum ReportStatus { initial, success, failure }

class ReportsState extends Equatable {
  const ReportsState({
    this.status = ReportStatus.initial,
    this.reports = const [],
    this.hasReachedMax = false,
  });

  final ReportStatus status;
  final List<Report> reports;
  final bool hasReachedMax;

  ReportsState copyWith({
    ReportStatus? status,
    List<Report>? reports,
    bool? hasReachedMax,
  }) {
    return ReportsState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      reports: reports ?? this.reports,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, reports: $reports }''';
  }

  @override
  List<Object?> get props => [status, reports, hasReachedMax];
}

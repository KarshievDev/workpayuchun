part of 'break_bloc.dart';

class BreakState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final PhoneBookUser? selectEmployee;
  final ReportBreakSummaryModel? breakSummaryModel;
  final ReportBreakListModel? reportBreakListModel;

  const BreakState(
      {this.status,
      this.currentMonth,
      this.selectEmployee,
      this.breakSummaryModel,
      this.reportBreakListModel});

  BreakState copyWith(
      {NetworkStatus? status,
      String? currentMonth,
      PhoneBookUser? selectEmployee,
      ReportBreakSummaryModel? breakSummaryModel,
      ReportBreakListModel? reportBreakListModel}) {
    return BreakState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        selectEmployee: selectEmployee ?? this.selectEmployee,
        breakSummaryModel: breakSummaryModel ?? this.breakSummaryModel,
        reportBreakListModel:
            reportBreakListModel ?? this.reportBreakListModel);
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
        selectEmployee,
        breakSummaryModel,
        reportBreakListModel
      ];
}

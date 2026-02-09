part of 'break_bloc.dart';

class BreakState extends Equatable {
  final NetworkStatus status;
  final Break? breakBack;
  final bool isTimerStart;
  final List<TodayBreakItem> breaks;
  final String? currentDate;
  final VerifyQRData? verifyQRData;
  final BreakReportModel? breakReportModel;
  final BreakType? selectedBreakType;
  final int? takeMeal;
  final String? remarks;

  const BreakState(
      {this.status = NetworkStatus.initial,
      this.breakBack,
      this.currentDate,
      this.isTimerStart = false,
      this.breaks = const [],
      this.verifyQRData,
      this.breakReportModel,
      this.selectedBreakType,
      this.takeMeal,
      this.remarks});

  BreakState copyWith(
      {NetworkStatus? status,
      Break? breakBack,
      bool? isTimerStart,
      List<TodayBreakItem>? breaks,
      BreakReportModel? breakReportModel,
      VerifyQRData? verifyQRData,
      String? currentDate,
      int? takeMeal,
      String? remarks,
      BreakType? selectedBreakType}) {
    return BreakState(
        status: status ?? this.status,
        breakBack: breakBack ?? this.breakBack,
        isTimerStart: isTimerStart ?? this.isTimerStart,
        breaks: breaks ?? this.breaks,
        currentDate: currentDate ?? this.currentDate,
        verifyQRData: verifyQRData ?? this.verifyQRData,
        breakReportModel: breakReportModel ?? this.breakReportModel,
        selectedBreakType: selectedBreakType ?? this.selectedBreakType,
        remarks: remarks ?? this.remarks,
        takeMeal: takeMeal ?? this.takeMeal);
  }

  @override
  List<Object?> get props =>
      [status, breakBack, isTimerStart, breaks, currentDate, verifyQRData, selectedBreakType, remarks, takeMeal];
}

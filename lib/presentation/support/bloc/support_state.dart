part of 'support_bloc.dart';

class SupportState extends Equatable {
  final NetworkStatus? status;
  final SupportListModel? supportListModel;
  final Filter filter;
  final String? currentMonth;
  final BodyPrioritySupport? bodyPrioritySupport;


  const SupportState(
      {this.status,
      this.supportListModel,
      this.filter = Filter.open,
      this.currentMonth,
      this.bodyPrioritySupport});

  SupportState copy(
      {NetworkStatus? status,
      SupportListModel? supportListModel,
      Filter? filter,
      String? currentMonth, BodyPrioritySupport? bodyPrioritySupport}) {
    return SupportState(
        status: status ?? this.status,
        supportListModel: supportListModel ?? this.supportListModel,
        filter: filter ?? this.filter,
    currentMonth: currentMonth ?? this.currentMonth,
    bodyPrioritySupport: bodyPrioritySupport ?? this.bodyPrioritySupport);
  }

  @override
  List<Object?> get props => [status, supportListModel, filter,currentMonth,bodyPrioritySupport];
}

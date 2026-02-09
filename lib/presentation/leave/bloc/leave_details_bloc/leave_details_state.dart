import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LeaveDetailsState extends Equatable {
  final NetworkStatus status;
  final LeaveDetailsModel? leaveDetailsModel;
  final bool isCancelled;

  const LeaveDetailsState({this.leaveDetailsModel, this.status = NetworkStatus.initial, this.isCancelled = false});

  LeaveDetailsState copyWith({NetworkStatus? status, bool? isCancelled, LeaveDetailsModel? leaveDetailsModel}) {
    return LeaveDetailsState(
        status: status ?? this.status,
        isCancelled: isCancelled ?? this.isCancelled,
        leaveDetailsModel: leaveDetailsModel ?? this.leaveDetailsModel);
  }

  @override
  List<Object?> get props => [status, leaveDetailsModel, isCancelled];
}

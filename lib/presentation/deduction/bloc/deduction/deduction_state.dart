import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';

class DeductionState extends Equatable {
  final NetworkStatus status;
  final DeductionData? deductionData;

  const DeductionState({this.status = NetworkStatus.initial, this.deductionData});

  DeductionState copyWith({NetworkStatus? status, DeductionData? deductionData}) {
    return DeductionState(status: status ?? this.status, deductionData: deductionData ?? this.deductionData);
  }

  @override
  List<Object?> get props => [status, deductionData];
}

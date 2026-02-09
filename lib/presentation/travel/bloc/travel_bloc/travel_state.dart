part of 'travel_bloc.dart';

class TravelState extends Equatable {
  final NetworkStatus? status;
  final TravelPlanModel? travelPlanModel;
  final String? fromDate;
  final String? toDate;
  final String? signedDate;
  final GlobalKey<SfSignaturePadState>? signaturePadKey;

  const TravelState(
      {this.status, this.travelPlanModel, this.fromDate, this.toDate, this.signedDate, this.signaturePadKey});

  TravelState copyWith(
      {NetworkStatus? status,
      TravelPlanModel? travelPlanModel,
      String? fromDate,
      String? toDate,
      String? signedDate,
      final GlobalKey<SfSignaturePadState>? signaturePadKey}) {
    return TravelState(
        status: status ?? this.status,
        travelPlanModel: travelPlanModel ?? this.travelPlanModel,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        signedDate: signedDate ?? this.signedDate,
        signaturePadKey: signaturePadKey ?? this.signaturePadKey);
  }

  @override
  List<Object?> get props => [status, travelPlanModel, fromDate, toDate, signedDate, signaturePadKey];
}

import 'package:equatable/equatable.dart';

class DeductionData extends Equatable {
  const DeductionData({
    this.result,
    this.message,
    this.deduction,
  });

  final bool? result;
  final String? message;
  final DeductionListData? deduction;

  factory DeductionData.fromJson(Map<String, dynamic> json) {
    return DeductionData(
        result: json['result'],
        message: json['message'],
        deduction: json['data'] != null ? DeductionListData.fromJson(json['data']) : null);
  }

  @override
  List<Object?> get props => [result, message, deduction];
}

class DeductionListData extends Equatable {
  const DeductionListData({
    required this.data,
  });

  final List<Deduction> data;

  factory DeductionListData.fromJson(Map<String, dynamic> json) {
    return DeductionListData(data: List.from(json['data']).map((e) => Deduction.fromJson(e)).toList());
  }

  @override
  List<Object?> get props => [data];
}

class Deduction extends Equatable {
  final int? id;
  final String? month;
  final String? amount;
  final String? considerAmount;
  final int? appealEnable;
  final String? isAppealed;
  final String? appealedAt;
  final String? appealApprovedBy;
  final String? appealApprovedAt;
  final String? appealStatus;
  final List<DeductionDetails>? deductionDetails;

  const Deduction(
      {this.id,
      this.month,
      this.amount,
      this.considerAmount,
      this.appealEnable,
      this.isAppealed,
      this.appealedAt,
      this.appealApprovedBy,
      this.appealApprovedAt,
      this.appealStatus,
      this.deductionDetails});

  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
        id: json['id'],
        month: json['month'],
        amount: json['amount'],
        considerAmount: json['consider_amount'],
        appealEnable: json['appeal_enable'],
        isAppealed: json['is_appealed'],
        appealedAt: json['appealed_at'],
        appealApprovedBy: json['appeal_approved_by'],
        appealApprovedAt: json['appeal_approved_at'],
        appealStatus: json['appeal_status'],
        deductionDetails: List.from(json['deduction_details']).map((e) => DeductionDetails.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['month'] = month;
    data['amount'] = amount;
    data['consider_amount'] = considerAmount;
    data['appeal_enable'] = appealEnable;
    data['is_appealed'] = isAppealed;
    data['appealed_at'] = appealedAt;
    data['appeal_approved_by'] = appealApprovedBy;
    data['appeal_approved_at'] = appealApprovedAt;
    data['appeal_status'] = appealStatus;
    if (deductionDetails != null) {
      data['deduction_details'] = deductionDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [id, month, amount, considerAmount, appealEnable, considerAmount, appealStatus];
}

class DeductionDetails extends Equatable {
  final int? id;
  final String? deductionType;
  final String? purpose;
  final String? amount;
  final int? days;
  final String? isApplicable;
  final String? consideredBy;
  final String? consideredAt;

  const DeductionDetails(
      {this.id,
      this.deductionType,
      this.purpose,
      this.amount,
      this.days,
      this.isApplicable,
      this.consideredBy,
      this.consideredAt});

  factory DeductionDetails.fromJson(Map<String, dynamic> json) {
    return DeductionDetails(
      id: json['id'],
      deductionType: json['deduction_type'],
      purpose: json['purpose'],
      amount: json['amount'],
      days: json['days'],
      isApplicable: json['is_applicable'],
      consideredBy: json['considered_by'],
      consideredAt: json['considered_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deduction_type'] = deductionType;
    data['purpose'] = purpose;
    data['amount'] = amount;
    data['days'] = days;
    data['is_applicable'] = isApplicable;
    data['considered_by'] = consideredBy;
    data['considered_at'] = consideredAt;
    return data;
  }

  @override
  List<Object?> get props => [id, deductionType, amount, days, isApplicable, consideredAt, consideredBy];
}

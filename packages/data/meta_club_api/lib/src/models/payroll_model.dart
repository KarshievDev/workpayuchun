import 'package:equatable/equatable.dart';

class PayrollModel extends Equatable{
  const PayrollModel({
    this.result,
    this.message,
    this.payrollListData,
  });

  final bool? result;
  final String? message;
  final List<PayrollList>? payrollListData;

  factory PayrollModel.fromJson(Map<String, dynamic> json) => PayrollModel(
    result: json["result"],
    message: json["message"],
    payrollListData: json["data"] == null ? [] : List<PayrollList>.from(json["data"]!.map((x) => PayrollList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": payrollListData == null ? [] : List<dynamic>.from(payrollListData!.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [result, message, payrollListData];
}

class PayrollList extends Equatable{
  const PayrollList({
    this.id,
    this.month,
    this.isCalculated,
    this.salary,
    this.payslipLink,
  });

  final int? id;
  final String? month;
  final bool? isCalculated;
  final double? salary;
  final String? payslipLink;

  factory PayrollList.fromJson(Map<String, dynamic> json) => PayrollList(
    id: json["id"],
    month: json["month"],
    isCalculated: json["is_calculated"],
    salary: double.tryParse('${json["salary"]}'),
    payslipLink: json["payslip_link"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "month": month,
    "is_calculated": isCalculated,
    "salary": salary,
    "payslip_link": payslipLink,
  };

  @override
  List<Object?> get props => [id, month, isCalculated, payslipLink];
}

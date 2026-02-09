import 'package:equatable/equatable.dart';

class ResponseExpenseList extends Equatable {
  const ResponseExpenseList({
    this.data = const [],
    this.result,
    this.message,
    this.paymentType = const [],
    this.expanseStatus = const [],
    this.status,
  });

  final List<ExpenseItem> data;
  final bool? result;
  final String? message;
  final List<ExpanseStatus> paymentType;
  final List<ExpanseStatus> expanseStatus;
  final int? status;

  factory ResponseExpenseList.fromJson(Map<String, dynamic> json) =>
      ResponseExpenseList(
        data: List<ExpenseItem>.from(json["data"].map((x) => ExpenseItem.fromJson(x))),
        result: json["result"],
        message: json["message"],
        paymentType: List<ExpanseStatus>.from(json["payment_type"].map((x) => ExpanseStatus.fromJson(x))),
        expanseStatus: List<ExpanseStatus>.from(json["expanse_status"].map((x) => ExpanseStatus.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "result": result,
        "message": message,
        "payment_type": List<dynamic>.from(paymentType.map((x) => x.toJson())),
        "expanse_status":
            List<dynamic>.from(expanseStatus.map((x) => x.toJson())),
        "status": status,
      };
  @override
  List<Object?> get props =>
      [result, message, data, paymentType, expanseStatus, status];
}

class ExpenseItem extends Equatable {
  const ExpenseItem({
    this.id,
    this.category,
    this.requestedAmount,
    this.approvedAmount,
    this.dateShow,
    this.dateDb,
    this.payment,
    this.paymentColor,
    this.status,
    this.statusColor,
    this.reason,
  });

  final int? id;
  final String? category;
  final String? requestedAmount;
  final String? approvedAmount;
  final String? dateShow;
  final String? dateDb;
  final String? payment;
  final String? paymentColor;
  final String? status;
  final String? statusColor;
  final String? reason;

  factory ExpenseItem.fromJson(Map<String, dynamic> json) => ExpenseItem(
        id: json["id"],
        category: json["category"],
        requestedAmount: json["requested_amount"],
        approvedAmount: json["approved_amount"],
        dateShow: json["date_show"],
        dateDb: json["date_db"],
        payment: json["payment"],
        paymentColor: json["payment_color"],
        status: json["status"],
        statusColor: json["status_color"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "requested_amount": requestedAmount,
        "approved_amount": approvedAmount,
        "date_show": dateShow,
        "date_db": dateDb,
        "payment": payment,
        "payment_color": paymentColor,
        "status": status,
        "status_color": statusColor,
        "reason": reason,
      };
  @override
  List<Object?> get props => [
        id,
        category,
        requestedAmount,
        approvedAmount,
        dateShow,
        dateDb,
        payment,
        paymentColor,
        status,
        statusColor,
        reason,
      ];
}

class ExpanseStatus extends Equatable {
  const ExpanseStatus({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory ExpanseStatus.fromJson(Map<String, dynamic> json) => ExpanseStatus(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

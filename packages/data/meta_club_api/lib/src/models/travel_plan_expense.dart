import 'package:meta_club_api/meta_club_api.dart';

class TravelExpense {
  final bool? result;
  final String? message;
  final Expenses? data;

  TravelExpense({
    this.result,
    this.message,
    this.data,
  });

  factory TravelExpense.fromRawJson(json) => TravelExpense.fromJson(json);

  factory TravelExpense.fromJson(Map<String, dynamic> json) => TravelExpense(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Expenses.fromJson(json["data"]),
  );
}

class Expenses {
  final List<Expense>? expenses;
  final Links? links;
  final Meta? meta;

  Expenses({
    this.expenses,
    this.links,
    this.meta,
  });

  factory Expenses.fromRawJson(json) => Expenses.fromJson(json);

  factory Expenses.fromJson(Map<String, dynamic> json) => Expenses(
    expenses: json["data"] == null ? [] : List<Expense>.from(json["data"]!.map((x) => Expense.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );
}

class Expense {
  final int? id;
  final int? travelPlanId;
  final TravelEmployee? employee;
  final DateTime? date;
  final String? modeOfTransportation;
  final String? totalAmount;
  final String? approvalAmount;
  final String? status;
  final int? rating;
  final Approve? approve;

  Expense({
    this.id,
    this.travelPlanId,
    this.employee,
    this.date,
    this.modeOfTransportation,
    this.totalAmount,
    this.approvalAmount,
    this.status,
    this.rating,
    this.approve,
  });

  factory Expense.fromRawJson(json) => Expense.fromJson(json);

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json["id"],
    travelPlanId: json["travel_plan_id"],
    employee: json["employee"] == null ? null : TravelEmployee.fromJson(json["employee"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    modeOfTransportation: json["mode_of_transportation"],
    totalAmount: json["total_amount"],
    approvalAmount: json["approval_amount"],
    status: json["status"],
    rating: json["rating"],
    approve: json["approve"] == null ? null : Approve.fromJson(json["approve"]),
  );
}

class TravelEmployee {
  final int? id;
  final String? name;
  final String? department;
  final String? designation;
  final String? avatar;

  TravelEmployee({
    this.id,
    this.name,
    this.department,
    this.designation,
    this.avatar,
  });

  factory TravelEmployee.fromRawJson(json) => TravelEmployee.fromJson(json);

  factory TravelEmployee.fromJson(Map<String, dynamic> json) => TravelEmployee(
    id: json["id"],
    name: json["name"],
    department: json["department"],
    designation: json["designation"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "department": department,
    "designation": designation,
    "avatar": avatar,
  };
}

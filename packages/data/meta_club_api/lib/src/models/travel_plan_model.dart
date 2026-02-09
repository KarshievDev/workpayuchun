import 'package:equatable/equatable.dart';

class TravelPlanModel extends Equatable{
  final bool? result;
  final String? message;
  final TravelData? data;

  const TravelPlanModel({
    this.result,
    this.message,
    this.data,
  });

  factory TravelPlanModel.fromJson(Map<String, dynamic> json) => TravelPlanModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : TravelData.fromJson(json["data"]),
  );

  @override
  List<Object?> get props => [result,message,data];


}

class TravelData extends Equatable{
  final List<TravelPlanItem>? data;
  final TravelLinks? links;
  final Meta? meta;

  const TravelData({
    this.data,
    this.links,
    this.meta,
  });

  factory TravelData.fromJson(Map<String, dynamic> json) => TravelData(
    data: json["data"] == null ? [] : List<TravelPlanItem>.from(json["data"]!.map((x) => TravelPlanItem.fromJson(x))),
    links: json["links"] == null ? null : TravelLinks.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  @override
  List<Object?> get props => [data,links,meta];


}

class TravelPlanItem extends Equatable{
  final int? id;
  final Employee? employee;
  final String? fromDate;
  final String? toDate;
  final String? fromLocation;
  final String? toLocation;
  final String? purpose;
  final String? amount;
  final String? signature;
  final String? signatureDate;
  final String? status;
  final Approve? approve;
  final Reject? reject;

  const TravelPlanItem({
    this.id,
    this.employee,
    this.fromDate,
    this.toDate,
    this.fromLocation,
    this.toLocation,
    this.purpose,
    this.amount,
    this.signature,
    this.signatureDate,
    this.status,
    this.approve,
    this.reject,
  });

  factory TravelPlanItem.fromJson(Map<String, dynamic> json) => TravelPlanItem(
    id: json["id"],
    employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    fromDate: json["from_date"],
    toDate: json["to_date"],
    fromLocation: json["from_location"],
    toLocation: json["to_location"],
    purpose: json["purpose"],
    amount: json["amount"],
    signature: json["signature"],
    signatureDate: json["signature_date"],
    status: json["status"],
    approve: json["approve"] == null ? null : Approve.fromJson(json["approve"]),
    reject: json["reject"] == null ? null : Reject.fromJson(json["reject"]),
  );

  @override
  List<Object?> get props => [id,employee,fromDate,toDate,fromLocation,toLocation,purpose,amount,signature,signatureDate,status,approve,reject];


}

class Approve extends Equatable {
  final dynamic approvedBy;
  final dynamic approvedAt;
  final String? approvedRemark;

  const Approve({
    this.approvedBy,
    this.approvedAt,
    this.approvedRemark,
  });

  factory Approve.fromJson(Map<String, dynamic> json) => Approve(
    approvedBy: json["approved_by"],
    approvedAt: json["approved_at"],
    approvedRemark: json["approved_remark"],
  );

  @override
  List<Object?> get props => [approvedAt,approvedBy,approvedRemark];


}

class Employee extends Equatable{
  final int? id;
  final String? name;
  final String? department;
  final String? designation;
  final String? avatar;

  const Employee({
    this.id,
    this.name,
    this.department,
    this.designation,
    this.avatar,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    department: json["department"],
    designation: json["designation"],
    avatar: json["avatar"],
  );

  @override
  List<Object?> get props => [id,name,department,designation,avatar];


}

class Reject extends Equatable{
  final String? rejectedBy;
  final String? rejectedAt;
  final String? rejectedRemark;

  const Reject({
    this.rejectedBy,
    this.rejectedAt,
    this.rejectedRemark,
  });

  factory Reject.fromJson(Map<String, dynamic> json) => Reject(
    rejectedBy: json["rejected_by"],
    rejectedAt: json["rejected_at"],
    rejectedRemark: json["rejected_remark"],
  );

  @override
  List<Object?> get props =>[rejectedAt,rejectedBy,rejectedRemark];


}

class TravelLinks extends Equatable{
  final String? first;
  final String? last;
  final dynamic prev;
  final dynamic next;

  const TravelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory TravelLinks.fromJson(Map<String, dynamic> json) => TravelLinks(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  @override
  List<Object?> get props => [first,last,prev,next];

}

class Meta extends Equatable{
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<Link>? links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  const Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  @override
  List<Object?> get props => [currentPage,from,lastPage,links,path,perPage,to,total];

}

class Link extends Equatable{
  final String? url;
  final String? label;
  final bool? active;

  const Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  @override
  List<Object?> get props => [url,label,active];

}

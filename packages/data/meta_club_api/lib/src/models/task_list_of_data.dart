import 'package:equatable/equatable.dart';

import '../../meta_club_api.dart';

class TaskStatusListResponse extends Equatable {
  final bool? result;
  final String? message;
  final TaskStatusData? data;

  const TaskStatusListResponse({
    this.result,
    this.message,
    this.data,
  });

  factory TaskStatusListResponse.fromJson(Map<String, dynamic> json) =>
      TaskStatusListResponse(
        result: json["result"],
        message: json["message"],
        data:
            json["data"] == null ? null : TaskStatusData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class TaskStatusData extends Equatable {
  final List<Priority>? priorities;
  final TaskListCollection? taskListCollection;

  const TaskStatusData({
    this.priorities,
    this.taskListCollection,
  });

  factory TaskStatusData.fromJson(Map<String, dynamic> json) => TaskStatusData(
        priorities: json["priorities"] == null
            ? []
            : List<Priority>.from(
                json["priorities"]!.map((x) => Priority.fromJson(x))),
        taskListCollection: json["task_list_collection"] == null
            ? null
            : TaskListCollection.fromJson(json["task_list_collection"]),
      );

  Map<String, dynamic> toJson() => {
        "priorities": priorities == null
            ? []
            : List<dynamic>.from(priorities!.map((x) => x.toJson())),
        "task_list_collection": taskListCollection?.toJson(),
      };

  @override
  List<Object?> get props => [priorities, taskListCollection];
}

class Priority extends Equatable {
  final String? title;
  final int? id;
  final int? count;
  final String? color;

  const Priority({
    this.title,
    this.id,
    this.count,
    this.color,
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        title: json["title"],
        id: json["id"],
        count: json["count"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "count": count,
        "color": color,
      };

  @override
  List<Object?> get props => [title, id, count, color];
}

class TaskListCollection extends Equatable {
  final List<TaskCollection>? tasks;
  final Pagination? pagination;
  final List<Statistics> statistics;

  const TaskListCollection({
    this.tasks,
    this.pagination,
    this.statistics = const []
  });

  factory TaskListCollection.fromJson(Map<String, dynamic> json) =>
      TaskListCollection(
        tasks: json["all_tasks_collection"]["tasks"] == null ? [] : List<TaskCollection>.from(json["all_tasks_collection"]["tasks"]!.map((x) => TaskCollection.fromJson(x))),
        statistics: List<Statistics>.from(json["statistics"].map((x) => Statistics.fromJson(x))),
        pagination: json["all_tasks_collection"]["pagination"] == null ? null : Pagination.fromJson(json["all_tasks_collection"]["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "tasks": tasks == null ? [] : List<dynamic>.from(tasks!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };

  @override
  List<Object?> get props => [tasks, pagination];
}

class Pagination extends Equatable {
  final int? total;
  final int? count;
  final int? perPage;
  final int? currentPage;
  final int? totalPages;

  const Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };

  @override
  List<Object?> get props => [total, count, perPage, currentPage, totalPages];
}

class TaskCollection extends Equatable {
  final int? id;
  final String? title;
  final String? dateRange;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? priority;
  final Status? status;
  final bool? isCreator;
  final int? usersCount;
  final int? actualCount;
  final List<Member>? members;
  final String? color;

  const TaskCollection({
    this.id,
    this.title,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.priority,
    this.status,
    this.isCreator,
    this.usersCount,
    this.actualCount,
    this.members,
    this.color,
  });

  factory TaskCollection.fromJson(Map<String, dynamic> json) => TaskCollection(
        id: json["id"],
        title: json["title"],
        dateRange: json["date_range"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        priority: json["priority"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        isCreator: json["is_creator"],
        usersCount: json["users_count"],
        actualCount: json["actual_count"],
        members: json["members"] == null
            ? []
            : List<Member>.from(
                json["members"]!.map((x) => Member.fromJson(x))),
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date_range": dateRange,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "priority": priority,
        "status": status?.toJson(),
        "is_creator": isCreator,
        "users_count": usersCount,
        "actual_count": actualCount,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "color": color,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        dateRange,
        startDate,
        endDate,
        priority,
        status,
        isCreator,
        usersCount,
        actualCount,
        members,
        color
      ];
}

class Member extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? designation;
  final String? department;
  final String? avatar;

  const Member({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.department,
    this.avatar,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        designation: json["designation"],
        department: json["department"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "designation": designation,
        "department": department,
        "avatar": avatar,
      };

  @override
  List<Object?> get props =>
      [id, name, phone, email, designation, department, avatar];
}

class Status extends Equatable {
  final int? id;
  final String? name;
  final String? statusClass;
  final String? colorCode;
  final int? branchId;
  final String? translatedName;

  const Status({
    this.id,
    this.name,
    this.statusClass,
    this.colorCode,
    this.branchId,
    this.translatedName,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        statusClass: json["class"],
        colorCode: json["color_code"],
        branchId: json["branch_id"],
        translatedName: json["translated_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "class": statusClass,
        "color_code": colorCode,
        "branch_id": branchId,
        "translated_name": translatedName,
      };

  @override
  List<Object?> get props =>
      [id, name, statusClass, colorCode, branchId, translatedName];
}

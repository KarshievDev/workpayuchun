import 'package:equatable/equatable.dart';

class TaskDetailsModel extends Equatable {
  final bool? result;
  final String? message;
  final TaskDetailsData? data;

  const TaskDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) =>
      TaskDetailsModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : TaskDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [result, message, data];
}

class TaskDetailsData extends Equatable {
  final List<TaskDetailsMember>? members;
  final List<TaskDetailsPriority>? priorities;
  final TaskDetails? taskDetails;

  const TaskDetailsData({
    this.members,
    this.priorities,
    this.taskDetails,
  });

  factory TaskDetailsData.fromJson(Map<String, dynamic> json) =>
      TaskDetailsData(
        members: json["members"] == null
            ? []
            : List<TaskDetailsMember>.from(
                json["members"]!.map((x) => TaskDetailsMember.fromJson(x))),
        priorities: json["priorities"] == null
            ? []
            : List<TaskDetailsPriority>.from(
                json["priorities"]!.map((x) => TaskDetailsPriority.fromJson(x))),
        taskDetails: json["task_details"] == null
            ? null
            : TaskDetails.fromJson(json["task_details"]),
      );

  Map<String, dynamic> toJson() => {
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "priorities": priorities == null
            ? []
            : List<dynamic>.from(priorities!.map((x) => x.toJson())),
        "task_details": taskDetails?.toJson(),
      };

  @override
  List<Object?> get props => [members, priorities, taskDetails];
}

class TaskDetailsMember extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? designation;
  final String? department;
  final String? avatar;

  const TaskDetailsMember({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.department,
    this.avatar,
  });

  factory TaskDetailsMember.fromJson(Map<String, dynamic> json) => TaskDetailsMember(
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

class TaskDetailsPriority extends Equatable {
  final String? title;
  final int? id;

  const TaskDetailsPriority({
    this.title,
    this.id,
  });

  factory TaskDetailsPriority.fromJson(Map<String, dynamic> json) => TaskDetailsPriority(
        title: json["title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
      };

  @override
  List<Object?> get props => [title, id];
}

class TaskDetails extends Equatable {
  final int? id;
  final String? title;
  final String? dbStartDate;
  final String? startDate;
  final DateTime? dbEndDate;
  final String? endDate;
  final String? date;
  final dynamic supervisor;
  final int? usersCount;
  final int? actualCount;
  final int? discussionsCount;
  final int? filesCount;
  final int? progress;
  final bool? isCompleted;
  final int? priorityId;
  final String? priority;
  final int? statusId;
  final String? status;
  final String? color;
  final String? description;
  final List<dynamic>? files;
  final List<dynamic>? discussion;

  const TaskDetails({
    this.id,
    this.title,
    this.dbStartDate,
    this.startDate,
    this.dbEndDate,
    this.endDate,
    this.date,
    this.supervisor,
    this.usersCount,
    this.actualCount,
    this.discussionsCount,
    this.filesCount,
    this.progress,
    this.isCompleted,
    this.priorityId,
    this.priority,
    this.statusId,
    this.status,
    this.color,
    this.description,
    this.files,
    this.discussion,
  });

  factory TaskDetails.fromJson(Map<String, dynamic> json) => TaskDetails(
        id: json["id"],
        title: json["title"],
        dbStartDate: json["db_start_date"],
        startDate: json["start_date"],
        dbEndDate: json["db_end_date"] == null
            ? null
            : DateTime.parse(json["db_end_date"]),
        endDate: json["end_date"],
        date: json["date"],
        supervisor: json["supervisor"],
        usersCount: json["users_count"],
        actualCount: json["actual_count"],
        discussionsCount: json["discussions_count"],
        filesCount: json["files_count"],
        progress: json["progress"],
        isCompleted: json["is_completed"],
        priorityId: json["priority_id"],
        priority: json["priority"],
        statusId: json["status_id"],
        status: json["status"],
        color: json["color"],
        description: json["description"],
        files: json["files"] == null
            ? []
            : List<dynamic>.from(json["files"]!.map((x) => x)),
        discussion: json["discussion"] == null
            ? []
            : List<dynamic>.from(json["discussion"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "db_start_date": dbStartDate,
        "start_date": startDate,
        "db_end_date":
            "${dbEndDate!.year.toString().padLeft(4, '0')}-${dbEndDate!.month.toString().padLeft(2, '0')}-${dbEndDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "date": date,
        "supervisor": supervisor,
        "users_count": usersCount,
        "actual_count": actualCount,
        "discussions_count": discussionsCount,
        "files_count": filesCount,
        "progress": progress,
        "is_completed": isCompleted,
        "priority_id": priorityId,
        "priority": priority,
        "status_id": statusId,
        "status": status,
        "color": color,
        "description": description,
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
        "discussion": discussion == null
            ? []
            : List<dynamic>.from(discussion!.map((x) => x)),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        dbStartDate,
        dbEndDate,
        endDate,
        date,
        supervisor,
        usersCount,
        actualCount,
        discussionsCount,
        discussion,
        filesCount,
        progress,
        isCompleted,
        priorityId,
        priority,
        statusId,
        status,
        color,
        description,
        files
      ];
}

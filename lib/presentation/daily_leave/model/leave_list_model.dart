class LeaveListModel {
  String userId;
  String month;
  String leaveStatus;
  String leaveType;

  LeaveListModel(
      {required this.userId,
      required this.month,
      required this.leaveStatus,
      required this.leaveType});

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "month": month,
        "leaveStatus": leaveStatus,
        "leaveType": leaveType,
      };
}
enum NetworkStatus { initial, loading, success, failure, successDialog, errorDialog }

enum ActionStatus { refresh, checkInOut, mode, location }

enum Filter { open, close, all }

enum InternetStatus { initial, online, offline }

enum AttendanceType { offline, normal, qr, face, selfie }

enum LeaveStatusEnum {
  canceled('Cancel'),
  approved('Approve'),
  pending('Pending'),
  rejected('Reject');

  final String status;

  const LeaveStatusEnum(this.status);

  static LeaveStatusEnum fromString(String status) {
    return LeaveStatusEnum.values.firstWhere(
      (e) => e.status == status,
      orElse: () => pending,
    );
  }
}

/// Enum representing different types of data updates in the application
enum UpdateType {
  /// Settings related updates
  settings,
  
  /// Dashboard data updates
  dashboard,
  
  /// Leave management updates
  leave,
  
  /// Payroll related updates
  payroll,
  
  /// Attendance data updates
  attendance,
  
  /// Authentication updates
  authentication,
  
  /// Meetings and appointments updates
  meetings,
  
  /// All data types updated
  all,
  
  /// Other miscellaneous updates
  others;

  /// Convert enum to string representation
  String get value {
    switch (this) {
      case UpdateType.settings:
        return 'settings';
      case UpdateType.dashboard:
        return 'dashboard';
      case UpdateType.leave:
        return 'leave';
      case UpdateType.payroll:
        return 'payroll';
      case UpdateType.attendance:
        return 'attendance';
      case UpdateType.authentication:
        return 'authentication';
      case UpdateType.meetings:
        return 'meetings';
      case UpdateType.all:
        return 'all';
      case UpdateType.others:
        return 'others';
    }
  }

  /// Create UpdateType from string
  static UpdateType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'settings':
        return UpdateType.settings;
      case 'dashboard':
        return UpdateType.dashboard;
      case 'leave':
        return UpdateType.leave;
      case 'payroll':
        return UpdateType.payroll;
      case 'attendance':
        return UpdateType.attendance;
      case 'authentication':
        return UpdateType.authentication;
      case 'meetings':
        return UpdateType.meetings;
      case 'all':
        return UpdateType.all;
      case 'others':
      default:
        return UpdateType.others;
    }
  }
}
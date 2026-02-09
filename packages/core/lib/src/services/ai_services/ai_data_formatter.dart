import 'dart:convert';
import '../home_services/global_home_bloc_accessor.dart';
import '../leave_services/global_leave_bloc_accessor.dart';
import '../authentication_services/global_authentication_bloc_accessor.dart';
import 'ai_models.dart';

/// Service for formatting and combining data from different sources for AI consumption
class AIDataFormatter {
  /// Get comprehensive AI context data combining home, leave, and authentication data
  static AIContextData getAIContextData() {
    final homeData = GlobalHomeBlocAccessor.instance.getHomeBlocDataAsMap();
    final leaveData = GlobalLeaveBlocAccessor.instance.getLeaveDataAsMap();
    final authData =
        GlobalAuthenticationBlocAccessor.instance.getAuthenticationDataAsMap();

    return AIContextData(
      homeData: homeData,
      leaveData: leaveData,
      authenticationData: authData,
      userInfo: _extractUserInfo(homeData, leaveData, authData),
      lastUpdated: DateTime.now(),
    );
  }

  /// Format data for AI consumption with enhanced structure
  static Map<String, dynamic> formatForAI({
    Map<String, dynamic>? homeData,
    Map<String, dynamic>? leaveData,
    Map<String, dynamic>? authenticationData,
    Map<String, dynamic>? additionalContext,
  }) {
    final result = <String, dynamic>{};

    // Add timestamp
    result['timestamp'] = DateTime.now().toIso8601String();

    // Format home data
    if (homeData != null && homeData.isNotEmpty) {
      result['home'] = _formatHomeData(homeData);
    }

    // Format leave data
    if (leaveData != null && leaveData.isNotEmpty) {
      result['leave'] = _formatLeaveData(leaveData);
    }

    // Format authentication data
    if (authenticationData != null && authenticationData.isNotEmpty) {
      result['authentication'] = _formatAuthenticationData(authenticationData);
    }

    // Add user summary
    result['userSummary'] = _generateUserSummary(
      homeData,
      leaveData,
      authenticationData,
    );

    // Add additional context
    if (additionalContext != null && additionalContext.isNotEmpty) {
      result['additionalContext'] = additionalContext;
    }

    return result;
  }

  /// Format home data for better AI understanding
  static Map<String, dynamic> _formatHomeData(Map<String, dynamic> homeData) {
    final formatted = <String, dynamic>{};

    // Format settings data
    if (homeData.containsKey('settings')) {
      formatted['userSettings'] = _formatSettings(homeData['settings']);
    }

    // Format dashboard data
    if (homeData.containsKey('dashboard')) {
      formatted['dashboardMetrics'] = _formatDashboard(homeData['dashboard']);
    }

    return formatted;
  }

  /// Format leave data for better AI understanding
  static Map<String, dynamic> _formatLeaveData(Map<String, dynamic> leaveData) {
    final formatted = <String, dynamic>{};

    // Format main leave data
    if (leaveData.containsKey('leave')) {
      final mainLeave = leaveData['leave'] as Map<String, dynamic>;

      // Format leave summary
      if (mainLeave.containsKey('leaveSummary')) {
        formatted['leaveSummary'] = _formatLeaveSummary(
          mainLeave['leaveSummary'],
        );
      }

      // Format leave requests
      if (mainLeave.containsKey('leaveRequests')) {
        formatted['leaveRequests'] = _formatLeaveRequests(
          mainLeave['leaveRequests'],
        );
      }

      // Format leave types
      if (mainLeave.containsKey('leaveTypes')) {
        formatted['availableLeaveTypes'] = _formatLeaveTypes(
          mainLeave['leaveTypes'],
        );
      }

      // Format selected leave type
      if (mainLeave.containsKey('selectedLeaveType')) {
        formatted['currentSelection'] = mainLeave['selectedLeaveType'];
      }

      // Format dates
      if (mainLeave.containsKey('currentMonth')) {
        formatted['selectedMonth'] = mainLeave['currentMonth'];
      }
      if (mainLeave.containsKey('startDate')) {
        formatted['startDate'] = mainLeave['startDate'];
      }
      if (mainLeave.containsKey('endDate')) {
        formatted['endDate'] = mainLeave['endDate'];
      }

      // Format selected employee
      if (mainLeave.containsKey('selectedEmployee')) {
        formatted['selectedEmployee'] = _formatEmployee(
          mainLeave['selectedEmployee'],
        );
      }
    }

    // Format daily leave data
    if (leaveData.containsKey('dailyLeave')) {
      formatted['dailyLeave'] = _formatDailyLeave(leaveData['dailyLeave']);
    }

    return formatted;
  }

  /// Format authentication data for better AI understanding
  static Map<String, dynamic> _formatAuthenticationData(
    Map<String, dynamic> authData,
  ) {
    final formatted = <String, dynamic>{};

    // Format main authentication data
    if (authData.containsKey('authentication')) {
      final mainAuth = authData['authentication'] as Map<String, dynamic>;

      // Format authentication status
      if (mainAuth.containsKey('status')) {
        formatted['authenticationStatus'] = mainAuth['status'];
      }

      if (mainAuth.containsKey('isAuthenticated')) {
        formatted['isUserAuthenticated'] = mainAuth['isAuthenticated'];
      }

      // Format user data for AI context (only non-sensitive information)
      if (mainAuth.containsKey('userData')) {
        formatted['userProfile'] = _formatUserProfile(mainAuth['userData']);
      }

      // Format session info
      if (mainAuth.containsKey('sessionInfo')) {
        formatted['sessionInfo'] = mainAuth['sessionInfo'];
      }
    }

    return formatted;
  }

  /// Format user profile data for AI understanding (excluding sensitive information)
  static Map<String, dynamic> _formatUserProfile(dynamic userData) {
    if (userData is! Map<String, dynamic>) return {};

    final formatted = <String, dynamic>{};

    // Extract safe user information
    if (userData.containsKey('userId')) {
      formatted['userId'] = userData['userId'];
    }
    if (userData.containsKey('userName')) {
      formatted['name'] = userData['userName'];
    }
    if (userData.containsKey('userEmail')) {
      formatted['email'] = userData['userEmail'];
    }
    if (userData.containsKey('designation')) {
      formatted['designation'] = userData['designation'];
    }
    if (userData.containsKey('department')) {
      formatted['department'] = userData['department'];
    }
    if (userData.containsKey('employeeId')) {
      formatted['employeeId'] = userData['employeeId'];
    }
    if (userData.containsKey('userRole')) {
      formatted['role'] = userData['userRole'];
    }
    if (userData.containsKey('accountType')) {
      formatted['accountType'] = userData['accountType'];
    }
    if (userData.containsKey('profileCompleteness')) {
      formatted['profileCompleteness'] = userData['profileCompleteness'];
    }
    if (userData.containsKey('hasCompleteProfile')) {
      formatted['hasCompleteProfile'] = userData['hasCompleteProfile'];
    }
    if (userData.containsKey('organizationName')) {
      formatted['organizationName'] = userData['organizationName'];
    }

    // Add summary for AI understanding
    final completeness = userData['profileCompleteness'] as int? ?? 0;
    if (completeness > 0) {
      formatted['profileSummary'] = 'User profile is $completeness% complete';
    }

    return formatted;
  }

  /// Format settings data
  static Map<String, dynamic> _formatSettings(dynamic settings) {
    if (settings is! Map<String, dynamic>) return {};

    return {
      'preferences': settings,
      'summary': 'User application settings and preferences',
    };
  }

  /// Format dashboard data
  static Map<String, dynamic> _formatDashboard(dynamic dashboard) {
    if (dashboard is! Map<String, dynamic>) return {};

    return {
      'metrics': dashboard,
      'summary': 'Current dashboard metrics and notifications',
      'lastUpdated': DateTime.now().toIso8601String(),
    };
  }

  /// Format leave summary for AI understanding
  static Map<String, dynamic> _formatLeaveSummary(dynamic leaveSummary) {
    if (leaveSummary is! Map<String, dynamic>) return {};

    final formatted = Map<String, dynamic>.from(leaveSummary);

    // Add calculated fields for AI understanding
    if (formatted.containsKey('total_leave') &&
        formatted.containsKey('total_used')) {
      final totalLeave = formatted['total_leave'] as int? ?? 0;
      final totalUsed = formatted['total_used'] as int? ?? 0;
      formatted['remaining_leave'] = totalLeave - totalUsed;
      formatted['usage_percentage'] =
          totalLeave > 0 ? (totalUsed / totalLeave * 100).round() : 0;
    }

    // Add summary text
    formatted['summary'] = _generateLeaveSummaryText(formatted);

    return formatted;
  }

  /// Format leave requests for AI understanding
  static Map<String, dynamic> _formatLeaveRequests(dynamic leaveRequests) {
    if (leaveRequests is! Map<String, dynamic>) return {};

    final formatted = Map<String, dynamic>.from(leaveRequests);

    // Add request analysis
    if (leaveRequests.containsKey('leaveRequests') &&
        leaveRequests['leaveRequests'] is List) {
      final requests = leaveRequests['leaveRequests'] as List;

      formatted['totalRequests'] = requests.length;
      formatted['activeRequests'] =
          requests.where((r) => r['status'] == 'Active').length;
      formatted['pendingRequests'] =
          requests.where((r) => r['status'] == 'Pending').length;
      formatted['rejectedRequests'] =
          requests.where((r) => r['status'] == 'Rejected').length;

      // Get recent requests
      formatted['recentRequests'] = requests.take(5).toList();

      formatted['summary'] = _generateLeaveRequestsSummaryText(formatted);
    }

    return formatted;
  }

  /// Format leave types for AI understanding
  static Map<String, dynamic> _formatLeaveTypes(dynamic leaveTypes) {
    if (leaveTypes is! Map<String, dynamic>) return {};

    final formatted = Map<String, dynamic>.from(leaveTypes);

    // Add analysis of available leave types
    if (leaveTypes.containsKey('available_leave') &&
        leaveTypes['available_leave'] is List) {
      final availableTypes = leaveTypes['available_leave'] as List;

      formatted['totalTypes'] = availableTypes.length;
      formatted['typesSummary'] =
          availableTypes
              .map(
                (type) => {
                  'type': type['type'] ?? 'Unknown',
                  'remaining': type['left_days'] ?? 0,
                  'total': type['total_leave'] ?? 0,
                },
              )
              .toList();

      formatted['summary'] = _generateLeaveTypesSummaryText(formatted);
    }

    return formatted;
  }

  /// Format daily leave data
  static Map<String, dynamic> _formatDailyLeave(dynamic dailyLeave) {
    if (dailyLeave is! Map<String, dynamic>) return {};

    final formatted = Map<String, dynamic>.from(dailyLeave);
    formatted['summary'] = 'Daily leave applications and requests';

    return formatted;
  }

  /// Format employee data
  static Map<String, dynamic> _formatEmployee(dynamic employee) {
    if (employee is! Map<String, dynamic>) return {};

    return {
      'id': employee['id'],
      'name': employee['name'],
      'designation': employee['designation'],
      'department':
          employee.containsKey('department') ? employee['department'] : null,
    };
  }

  /// Extract user information from combined data
  static Map<String, dynamic> _extractUserInfo(
    Map<String, dynamic> homeData,
    Map<String, dynamic> leaveData,
    Map<String, dynamic> authenticationData,
  ) {
    final userInfo = <String, dynamic>{};

    // Extract from home data
    if (homeData.containsKey('settings')) {
      // Add user preferences and settings
      userInfo['preferences'] = homeData['settings'];
    }

    if (homeData.containsKey('dashboard')) {
      // Extract user-specific dashboard info
      userInfo['dashboardSummary'] = 'Dashboard data available';
    }

    // Extract from leave data
    if (leaveData.containsKey('leave')) {
      final mainLeave = leaveData['leave'] as Map<String, dynamic>;
      if (mainLeave.containsKey('selectedEmployee')) {
        userInfo['employee'] = mainLeave['selectedEmployee'];
      }
    }

    // Extract from authentication data (primary user info)
    if (authenticationData.containsKey('authentication')) {
      final mainAuth =
          authenticationData['authentication'] as Map<String, dynamic>;
      if (mainAuth.containsKey('userData')) {
        userInfo['currentUser'] = mainAuth['userData'];
      }
      if (mainAuth.containsKey('isAuthenticated')) {
        userInfo['isAuthenticated'] = mainAuth['isAuthenticated'];
      }
      if (mainAuth.containsKey('sessionInfo')) {
        userInfo['sessionInfo'] = mainAuth['sessionInfo'];
      }
    }

    return userInfo;
  }

  /// Generate user summary for AI context
  static Map<String, dynamic> _generateUserSummary(
    Map<String, dynamic>? homeData,
    Map<String, dynamic>? leaveData,
    Map<String, dynamic>? authenticationData,
  ) {
    final summary = <String, dynamic>{};

    // Home data summary
    if (homeData != null && homeData.isNotEmpty) {
      summary['hasHomeData'] = true;
      summary['homeDataKeys'] = homeData.keys.toList();
    } else {
      summary['hasHomeData'] = false;
    }

    // Leave data summary
    if (leaveData != null && leaveData.isNotEmpty) {
      summary['hasLeaveData'] = true;
      summary['leaveDataKeys'] = leaveData.keys.toList();

      // Extract key leave metrics
      if (leaveData.containsKey('leave')) {
        final mainLeave = leaveData['leave'] as Map<String, dynamic>;
        if (mainLeave.containsKey('leaveSummary')) {
          final leaveSummary =
              mainLeave['leaveSummary'] as Map<String, dynamic>?;
          if (leaveSummary != null) {
            summary['totalLeave'] = leaveSummary['total_leave'] ?? 0;
            summary['usedLeave'] = leaveSummary['total_used'] ?? 0;
            summary['remainingLeave'] = leaveSummary['leave_balance'] ?? 0;
          }
        }
      }
    } else {
      summary['hasLeaveData'] = false;
    }

    // Authentication data summary
    if (authenticationData != null && authenticationData.isNotEmpty) {
      summary['hasAuthenticationData'] = true;
      summary['authenticationDataKeys'] = authenticationData.keys.toList();

      // Extract key auth metrics
      if (authenticationData.containsKey('authentication')) {
        final mainAuth =
            authenticationData['authentication'] as Map<String, dynamic>;
        summary['isAuthenticated'] = mainAuth['isAuthenticated'] ?? false;
        summary['authenticationStatus'] = mainAuth['status'] ?? 'unknown';

        if (mainAuth.containsKey('userData')) {
          final userData = mainAuth['userData'] as Map<String, dynamic>?;
          if (userData != null) {
            summary['userName'] = userData['userName'] ?? 'Unknown';
            summary['userRole'] = userData['userRole'] ?? 'Employee';
            summary['accountType'] = userData['accountType'] ?? 'Unknown';
            summary['profileCompleteness'] =
                userData['profileCompleteness'] ?? 0;
          }
        }
      }
    } else {
      summary['hasAuthenticationData'] = false;
    }

    summary['dataFreshness'] = DateTime.now().toIso8601String();

    return summary;
  }

  /// Generate leave summary text for AI
  static String _generateLeaveSummaryText(Map<String, dynamic> summary) {
    final totalLeave = summary['total_leave'] ?? 0;
    final totalUsed = summary['total_used'] ?? 0;
    final remaining = summary['remaining_leave'] ?? 0;
    final usagePercentage = summary['usage_percentage'] ?? 0;

    return 'User has $totalLeave total leave days, used $totalUsed days ($usagePercentage% usage), with $remaining days remaining';
  }

  /// Generate leave requests summary text
  static String _generateLeaveRequestsSummaryText(
    Map<String, dynamic> requests,
  ) {
    final total = requests['totalRequests'] ?? 0;
    final active = requests['activeRequests'] ?? 0;
    final pending = requests['pendingRequests'] ?? 0;
    final rejected = requests['rejectedRequests'] ?? 0;

    return 'User has $total total leave requests: $active active, $pending pending, $rejected rejected';
  }

  /// Generate leave types summary text
  static String _generateLeaveTypesSummaryText(Map<String, dynamic> types) {
    final totalTypes = types['totalTypes'] ?? 0;
    return 'User has $totalTypes different leave types available with varying balances';
  }

  /// Get current data snapshot for AI processing
  static Map<String, dynamic> getCurrentDataSnapshot() {
    return formatForAI(
      homeData: GlobalHomeBlocAccessor.instance.getHomeBlocDataAsMap(),
      leaveData: GlobalLeaveBlocAccessor.instance.getLeaveDataAsMap(),
      authenticationData:
          GlobalAuthenticationBlocAccessor.instance
              .getAuthenticationDataAsMap(),
    );
  }

  /// Convert data to JSON string for AI model
  static String toJSONString(Map<String, dynamic> data) {
    try {
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (e) {
      return data.toString();
    }
  }
}

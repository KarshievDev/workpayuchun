import 'dart:async';
import 'package:core/core.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:get_it/get_it.dart';

/// Simple global accessor for Authentication BLoC state
class GlobalAuthenticationBlocAccessor {
  static GlobalAuthenticationBlocAccessor? _instance;

  static GlobalAuthenticationBlocAccessor get instance =>
      _instance ??= GlobalAuthenticationBlocAccessor._();

  GlobalAuthenticationBlocAccessor._();

  dynamic _authenticationBloc;
  dynamic _authenticationState;
  StreamSubscription? _authenticationSubscription;

  /// Event bus for publishing authentication data updates
  EventBus get _eventBus => GetIt.instance.get<EventBus>();

  /// Get current Authentication BLoC state (returns null if not available)
  dynamic get authenticationState => _authenticationState;

  /// Check if Authentication BLoC is available
  bool get isAuthenticationAvailable => _authenticationBloc != null;

  /// Check if any authentication BLoC is available
  bool get isAvailable => isAuthenticationAvailable;

  /// Register Authentication BLoC instance
  void registerAuthenticationBloc(dynamic authenticationBloc) {
    _authenticationSubscription?.cancel();
    _authenticationBloc = authenticationBloc;
    _authenticationState = _authenticationBloc?.state;

    /// Listen to state changes to keep reference fresh and publish events
    _authenticationSubscription = authenticationBloc.stream.listen((state) {
      _authenticationState = state;
      _publishAuthenticationDataUpdateEvent();
    });
  }

  /// Get authentication data as Map for AI model consumption
  Map<String, dynamic> getAuthenticationDataAsMap() {
    final Map<String, dynamic> result = {};

    // Add main authentication data
    if (_authenticationState != null) {
      final authData = <String, dynamic>{};

      // Add authentication status
      if (_authenticationState.status != null) {
        authData['status'] = _authenticationState.status.toString();
        authData['isAuthenticated'] = _authenticationState.status.toString().contains('authenticated');
      }

      // Add user data
      if (_authenticationState.data != null) {
        try {
          final userData = _authenticationState.data.toJson();
          authData['userData'] = _extractUserDataForAI(userData);
        } catch (e) {
          // Fallback to basic data extraction
          authData['userData'] = _extractBasicAuthData(_authenticationState.data);
        }
      }

      // Add session info
      authData['sessionInfo'] = {
        'hasActiveSession': _authenticationState.status.toString().contains('authenticated'),
        'lastUpdated': DateTime.now().toIso8601String(),
      };

      if (authData.isNotEmpty) {
        result['authentication'] = authData;
      }
    }
    return result;
  }

  /// Extract user data specifically for AI consumption (excluding sensitive information)
  Map<String, dynamic> _extractUserDataForAI(Map<String, dynamic> userData) {
    final Map<String, dynamic> result = {};

    // Extract only non-sensitive user information for AI
    if (userData.containsKey('data')) {
      final user = userData['data'] as Map<String, dynamic>?;
      if (user != null) {
        // Safe user information for AI context
        result['userId'] = user['id'];
        result['userName'] = user['name'];
        result['userEmail'] = user['email'];
        result['designation'] = user['designation'];
        result['department'] = user['department'];
        result['employeeId'] = user['employee_id'];
        result['joiningDate'] = user['joining_date'];
        result['userRole'] = user['role'];
        
        // Add profile completion info
        final profileFields = ['name', 'email', 'designation', 'department'];
        final completedFields = profileFields.where((field) => 
          user[field] != null && user[field].toString().isNotEmpty).length;
        result['profileCompleteness'] = (completedFields / profileFields.length * 100).round();
      }
    }

    // Extract company/organization info if available
    if (userData.containsKey('organization')) {
      final org = userData['organization'] as Map<String, dynamic>?;
      if (org != null) {
        result['organizationName'] = org['name'];
        result['organizationType'] = org['type'];
      }
    }

    // Add session metadata
    result['accountType'] = _determineAccountType(userData);
    result['hasCompleteProfile'] = _hasCompleteProfile(userData);
    
    return result;
  }

  /// Extract basic data from objects that might not have toJson method
  Map<String, dynamic> _extractBasicAuthData(dynamic data) {
    if (data == null) return {};

    final Map<String, dynamic> result = {};

    try {
      // Use reflection-like approach to extract common fields
      final fields = data.runtimeType.toString();
      result['type'] = fields;

      // Extract string representation (avoid sensitive data)
      final dataString = data.toString();
      if (!_containsSensitiveInfo(dataString)) {
        result['data'] = dataString;
      }
    } catch (e) {
      result['data'] = 'Authentication data available but not parseable';
    }

    return result;
  }

  /// Check if string contains sensitive information
  bool _containsSensitiveInfo(String data) {
    final sensitiveKeywords = ['token', 'password', 'secret', 'key', 'auth'];
    return sensitiveKeywords.any((keyword) => 
      data.toLowerCase().contains(keyword));
  }

  /// Determine account type from user data
  String _determineAccountType(Map<String, dynamic> userData) {
    if (userData.containsKey('data')) {
      final user = userData['data'] as Map<String, dynamic>?;
      if (user != null) {
        final role = user['role']?.toString().toLowerCase() ?? '';
        if (role.contains('admin')) return 'Administrator';
        if (role.contains('manager')) return 'Manager';
        if (role.contains('hr')) return 'HR';
        return 'Employee';
      }
    }
    return 'Unknown';
  }

  /// Check if user has complete profile
  bool _hasCompleteProfile(Map<String, dynamic> userData) {
    if (userData.containsKey('data')) {
      final user = userData['data'] as Map<String, dynamic>?;
      if (user != null) {
        final requiredFields = ['name', 'email', 'designation'];
        return requiredFields.every((field) => 
          user[field] != null && user[field].toString().isNotEmpty);
      }
    }
    return false;
  }

  /// Publish authentication data update event
  void _publishAuthenticationDataUpdateEvent([
    UpdateType updateType = UpdateType.authentication,
  ]) {
    final authData = getAuthenticationDataAsMap();

    if (authData.isNotEmpty) {
      final event = GlobalDataUpdateEvent(
        authenticationData: authData,
        updateType: updateType,
        timeStamp: DateTime.now(),
      );
      _eventBus.fire(event);
    }
  }

  /// Clear cached data and reset state
  void clearCache() {
    _authenticationState = null;
    _publishAuthenticationDataUpdateEvent(UpdateType.authentication);
  }

  /// Dispose resources
  void dispose() {
    _authenticationSubscription?.cancel();
    _authenticationBloc = null;
    _authenticationState = null;
  }
}
import 'dart:async';
import 'package:core/core.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:get_it/get_it.dart';

/// Simple global accessor for Leave BLoCs state
class GlobalLeaveBlocAccessor {
  static GlobalLeaveBlocAccessor? _instance;

  static GlobalLeaveBlocAccessor get instance =>
      _instance ??= GlobalLeaveBlocAccessor._();

  GlobalLeaveBlocAccessor._();

  dynamic _leaveBloc;
  dynamic _leaveState;
  StreamSubscription? _leaveSubscription;
  StreamSubscription? _dailyLeaveSubscription;

  /// Event bus for publishing leave data updates
  EventBus get _eventBus => GetIt.instance.get<EventBus>();

  /// Get current Leave BLoC state (returns null if not available)
  dynamic get leaveState => _leaveState;

  /// Check if Leave BLoC is available
  bool get isLeaveAvailable => _leaveBloc != null;

  /// Check if any leave BLoC is available
  bool get isAvailable => isLeaveAvailable;

  /// Register Leave BLoC instance
  void registerLeaveBloc(dynamic leaveBloc) {
    _leaveSubscription?.cancel();
    _leaveBloc = leaveBloc;
    _leaveState = _leaveBloc?.state;

    /// Listen to state changes to keep reference fresh and publish events
    _leaveSubscription = leaveBloc.stream.listen((state) {
      _leaveState = state;
    });
  }

  /// Get leave data as Map for AI model consumption
  Map<String, dynamic> getLeaveDataAsMap() {
    final Map<String, dynamic> result = {};

    // Add main leave data
    if (_leaveState != null) {
      final leaveData = <String, dynamic>{};

      // Add leave summary data
      if (_leaveState.leaveSummaryModel?.leaveSummaryData != null) {
        try {
          leaveData['leaveSummary'] =
              _leaveState.leaveSummaryModel.leaveSummaryData.toJson();
        } catch (e) {
          // Fallback to basic data extraction
          leaveData['leaveSummary'] = _extractBasicLeaveData(
            _leaveState.leaveSummaryModel.leaveSummaryData,
          );
        }
      }

      // Add leave request data
      if (_leaveState.leaveRequestModel?.leaveRequestData != null) {
        try {
          leaveData['leaveRequests'] =
              _leaveState.leaveRequestModel.leaveRequestData.toJson();
        } catch (e) {
          // Fallback to basic data extraction
          leaveData['leaveRequests'] = _extractBasicLeaveData(
            _leaveState.leaveRequestModel.leaveRequestData,
          );
        }
      }

      // Add leave request type data
      if (_leaveState.leaveRequestType?.leaveRequestType != null) {
        try {
          leaveData['leaveTypes'] =
              _leaveState.leaveRequestType.leaveRequestType.toJson();
        } catch (e) {
          // Fallback to basic data extraction
          leaveData['leaveTypes'] = _extractBasicLeaveData(
            _leaveState.leaveRequestType.leaveRequestType,
          );
        }
      }

      // Add selected leave type
      if (_leaveState.selectedRequestType != null) {
        try {
          leaveData['selectedLeaveType'] =
              _leaveState.selectedRequestType.toJson();
        } catch (e) {
          leaveData['selectedLeaveType'] = _extractBasicLeaveData(
            _leaveState.selectedRequestType,
          );
        }
      }

      // Add leave details
      if (_leaveState.leaveDetailsModel?.leaveDetailsData != null) {
        try {
          leaveData['leaveDetails'] =
              _leaveState.leaveDetailsModel.leaveDetailsData.toJson();
        } catch (e) {
          leaveData['leaveDetails'] = _extractBasicLeaveData(
            _leaveState.leaveDetailsModel.leaveDetailsData,
          );
        }
      }

      // Add current month and date selection
      if (_leaveState.currentMonth != null) {
        leaveData['currentMonth'] = _leaveState.currentMonth;
      }

      if (_leaveState.startDate != null) {
        leaveData['startDate'] = _leaveState.startDate;
      }

      if (_leaveState.endDate != null) {
        leaveData['endDate'] = _leaveState.endDate;
      }

      // Add selected employee data
      if (_leaveState.selectedEmployee != null) {
        try {
          leaveData['selectedEmployee'] = _leaveState.selectedEmployee.toJson();
        } catch (e) {
          leaveData['selectedEmployee'] = _extractBasicLeaveData(
            _leaveState.selectedEmployee,
          );
        }
      }

      if (leaveData.isNotEmpty) {
        result['leave'] = leaveData;
      }
    }
    return result;
  }

  /// Extract basic data from objects that might not have toJson method
  Map<String, dynamic> _extractBasicLeaveData(dynamic data) {
    if (data == null) return {};

    final Map<String, dynamic> result = {};

    try {
      // Use reflection-like approach to extract common fields
      final fields = data.runtimeType.toString();
      result['type'] = fields;

      // Try to access common properties through dynamic calls
      if (data is List) {
        result['items'] =
            data.map((item) => _extractBasicLeaveData(item)).toList();
      } else {
        // Extract string representation
        result['data'] = data.toString();
      }
    } catch (e) {
      result['data'] = data.toString();
    }

    return result;
  }

  /// Publish leave data update event
  void _publishLeaveDataUpdateEvent([
    UpdateType updateType = UpdateType.leave,
  ]) {
    final leaveData = getLeaveDataAsMap();

    if (leaveData.isNotEmpty) {
      final event = GlobalDataUpdateEvent(
        leaveData: leaveData,
        updateType: updateType,
        timeStamp: DateTime.now(),
      );
      _eventBus.fire(event);
    }
  }

  /// Clear cached data and reset state
  void clearCache() {
    _leaveState = null;
    _publishLeaveDataUpdateEvent(UpdateType.leave);
  }

  /// Dispose resources
  void dispose() {
    _leaveSubscription?.cancel();
    _dailyLeaveSubscription?.cancel();
    _leaveBloc = null;
    _leaveState = null;
  }
}

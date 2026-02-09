import 'dart:async';
import 'package:core/core.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:get_it/get_it.dart';

/// Simple global accessor for HomeBloc state
class GlobalHomeBlocAccessor {
  static GlobalHomeBlocAccessor? _instance;

  static GlobalHomeBlocAccessor get instance =>
      _instance ??= GlobalHomeBlocAccessor._();

  GlobalHomeBlocAccessor._();

  dynamic _homeBloc;
  dynamic _homeState;
  StreamSubscription? _subscription;

  /// Event bus for publishing home data updates
  EventBus get _eventBus => GetIt.instance.get<EventBus>();

  /// Get current HomeBloc state (returns null if not available)
  dynamic get homeState => _homeState;

  /// Check if HomeBloc is available
  bool get isAvailable => _homeBloc != null;

  /// Register HomeBloc instance
  void registerHomeBloc(dynamic homeBloc) {
    _subscription?.cancel();
    _homeBloc = homeBloc;
    _homeState = _homeBloc?.state;

    /// Listen to state changes to keep reference fresh and publish events
    _subscription = homeBloc.stream.listen((state) {
      _homeState = state;
      _publishHomeDataUpdateEvent();
    });
  }

  /// Get home data as Map for greeting service
  Map<String, dynamic> getHomeBlocDataAsMap() {
    final state = homeState;
    if (state == null) return {};

    final Map<String, dynamic> result = {};

    // Add settings data
    if (state.settings?.data != null) {
      result['settings'] = state.settings.data.toJson();
    }

    // Add dashboard data
    if (state.dashboardModel?.data != null) {
      final data = state.dashboardModel.data;
      result['dashboard'] = data.toJson();
    }

    return result;
  }

  /// Publish home data update event
  void _publishHomeDataUpdateEvent([UpdateType updateType = UpdateType.all]) {
    final homeData = getHomeBlocDataAsMap();

    if (homeData.isNotEmpty) {
      final event = GlobalDataUpdateEvent(
        homeData: homeData,
        updateType: updateType,
        timeStamp: DateTime.now(),
      );
      _eventBus.fire(event);
    } else {}
  }

  /// Publish specific type of data update
  void publishDataUpdate(UpdateType updateType) {
    _publishHomeDataUpdateEvent(updateType);
  }

  /// Trigger voice greeting manually
  void triggerVoiceGreeting({
    bool forceShow = false,
    String? customGreeting,
    String? customStatus,
  }) {
    _eventBus.fire(
      VoiceGreetingTriggerEvent(
        forceShow: forceShow,
        customGreeting: customGreeting,
        customStatus: customStatus,
      ),
    );
  }

  /// Manual method to trigger home data update event (for testing)
  void triggerHomeDataUpdate([UpdateType updateType = UpdateType.all]) {
    _publishHomeDataUpdateEvent(updateType);
  }

  /// Dispose resources
  void dispose() {
    _subscription?.cancel();
    _homeBloc = null;
  }
}

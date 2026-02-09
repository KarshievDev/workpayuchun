import 'package:core/core.dart';
import 'package:event_bus_plus/event_bus_plus.dart';

/// Event fired when global bloc data is updated
class GlobalDataUpdateEvent extends AppEvent {
  /// The updated home data as a map
  final Map<String, dynamic>? homeData;

  /// The updated leave data as a map
  final Map<String, dynamic>? leaveData;

  /// The updated authentication data as a map
  final Map<String, dynamic>? authenticationData;

  /// Type of update
  final UpdateType updateType;

  /// Timestamp when the update occurred
  final DateTime timeStamp;

  const GlobalDataUpdateEvent({
    this.homeData,
    this.leaveData,
    this.authenticationData,
    required this.updateType,
    required this.timeStamp,
  });

  @override
  List<Object?> get props => [homeData, leaveData, authenticationData, updateType, timeStamp];
}

/// Event fired when voice greeting should be triggered
/// We can use this to force show greeting or provide custom messages
class VoiceGreetingTriggerEvent extends AppEvent {
  /// Force show greeting even if already shown
  final bool forceShow;

  /// Optional custom greeting message
  final String? customGreeting;

  /// Optional custom status summary
  final String? customStatus;

  const VoiceGreetingTriggerEvent({
    this.forceShow = false,
    this.customGreeting,
    this.customStatus,
  });

  @override
  List<Object?> get props => [forceShow, customGreeting, customStatus];
}

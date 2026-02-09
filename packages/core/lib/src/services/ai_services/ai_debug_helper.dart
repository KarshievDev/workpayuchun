import 'dart:convert';
import 'dart:developer' as developer;
import '../leave_services/global_leave_bloc_accessor.dart';
import '../home_services/global_home_bloc_accessor.dart';
import 'ai_data_formatter.dart';

/// Debug helper for AI service data transmission
class AIDebugHelper {
  
  /// Check what data is available from the accessors
  static Map<String, dynamic> debugDataAvailability() {
    final result = <String, dynamic>{};
    
    // Check home data availability
    result['homeAccessor'] = {
      'isAvailable': GlobalHomeBlocAccessor.instance.isAvailable,
      'homeState': GlobalHomeBlocAccessor.instance.homeState != null,
      'data': GlobalHomeBlocAccessor.instance.getHomeBlocDataAsMap(),
    };
    
    // Check leave data availability
    result['leaveAccessor'] = {
      'isAvailable': GlobalLeaveBlocAccessor.instance.isAvailable,
      'leaveState': GlobalLeaveBlocAccessor.instance.leaveState != null,
      'data': GlobalLeaveBlocAccessor.instance.getLeaveDataAsMap(),
    };
    
    // Check combined data
    result['combinedData'] = AIDataFormatter.getCurrentDataSnapshot();
    
    result['timestamp'] = DateTime.now().toIso8601String();
    
    return result;
  }
  
  /// Print debug information in readable format
  static void printDebugInfo() {
    final debugInfo = debugDataAvailability();
    developer.log('=== AI Debug Information ===');
    developer.log(const JsonEncoder.withIndent('  ').convert(debugInfo));
    developer.log('=== End Debug Information ===');
  }
  
  /// Get debug information as a formatted string
  static String getDebugInfoAsString() {
    final debugInfo = debugDataAvailability();
    return const JsonEncoder.withIndent('  ').convert(debugInfo);
  }
  
  /// Check if the required data is available for AI processing
  static bool isDataReadyForAI() {
    final homeData = GlobalHomeBlocAccessor.instance.getHomeBlocDataAsMap();
    final leaveData = GlobalLeaveBlocAccessor.instance.getLeaveDataAsMap();
    
    return homeData.isNotEmpty || leaveData.isNotEmpty;
  }
  
  /// Get simple status for UI display
  static Map<String, dynamic> getSimpleStatus() {
    return {
      'homeDataAvailable': GlobalHomeBlocAccessor.instance.isAvailable,
      'leaveDataAvailable': GlobalLeaveBlocAccessor.instance.isAvailable,
      'dataReadyForAI': isDataReadyForAI(),
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
import 'package:core/core.dart' as core;
import 'package:flutter/cupertino.dart';
import 'ai_service.dart' as local;

/// AI Service implementation using Core AI Service with Gemini
class GeminiAIService implements local.AIService {
  static const String _defaultApiKey =
      'AIzaSyDXf0_sgsCnIjSw7m0knZx4eTNreo4CRTs';

  late String _conversationId;
  bool _isInitialized = false;

  GeminiAIService() {
    _conversationId = core.AIService.instance.generateConversationId();
  }

  /// Initialize the Gemini AI service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize AI config manager
      await core.AIConfigManager.instance.initialize();

      // Clear existing configuration and create new one with correct model
      await core.AIConfigManager.instance.clearConfiguration();
      
      // Also clear AI service instance to ensure fresh initialization
      core.AIService.instance.dispose();
      
      const config = core.AIConfiguration(
        apiKey: _defaultApiKey,
        model: 'gemini-2.5-flash',
        temperature: 0.7,
        maxTokens: 2048,
        enableConversationMemory: true,
        conversationTimeout: const Duration(minutes: 30),
      );

      await core.AIConfigManager.instance.saveConfiguration(config);

      // Initialize the AI service
      final success = await core.AIConfigManager.instance.initializeAIService();

      if (!success) {
        throw Exception('Failed to initialize AI service');
      }

      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize Gemini AI service: $e');
    }
  }

  @override
  Future<String> generateResponse(String userMessage) async {
    // Ensure service is initialized
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // Debug: Check data availability
      debugPrint('=== Gemini AI Service Debug ===');
      debugPrint('User message: $userMessage');
      
      final debugInfo = core.AIDebugHelper.debugDataAvailability();
      debugPrint('Data availability: ${debugInfo['homeAccessor']['isAvailable']} (home), ${debugInfo['leaveAccessor']['isAvailable']} (leave)');
      debugPrint('Combined data keys: ${debugInfo['combinedData']?.keys?.toList()}');

      // Auto-detect query type from user message
      final queryType = core.AIPromptBuilder.detectQueryType(userMessage);
      debugPrint('Detected query type: ${queryType.name}');

      // Create AI request
      final request = core.AIRequest(
        query: userMessage,
        queryType: queryType,
        conversationId: _conversationId,
      );

      debugPrint('Sending request to core AI service...');
      
      // Process query with core AI service
      final response = await core.AIService.instance.processQuery(request);

      debugPrint('Response success: ${response.isSuccess}');
      if (!response.isSuccess) {
        debugPrint('Response error: ${response.error}');
      }

      if (response.isSuccess) {
        return response.response;
      } else {
        // Return fallback response if AI service fails
        return _getFallbackResponse(userMessage, response.error);
      }
    } catch (e) {
      // Return fallback response on error
      return _getFallbackResponse(userMessage, e.toString());
    }
  }

  /// Get fallback response when AI service fails
  String _getFallbackResponse(String userMessage, String? error) {
    final message = userMessage.toLowerCase();

    // Provide basic HR-related fallback responses
    if (message.contains('leave') || message.contains('vacation')) {
      return 'I\'m having trouble accessing your leave information right now. Please check your leave balance in the Leave section of the app, or contact HR for assistance.';
    }

    if (message.contains('attendance')) {
      return 'I can\'t access your attendance data at the moment. Please check the Attendance section of the app or speak with your supervisor for details.';
    }

    if (message.contains('hello') || message.contains('hi')) {
      return 'Hello! I\'m your HR assistant, but I\'m experiencing some technical difficulties right now. Please try again later or use the app\'s menu to navigate to what you need.';
    }

    if (message.contains('help')) {
      return 'I\'m here to help with HR-related questions, but I\'m having technical issues right now. You can navigate through the app using the menu, or contact HR directly for assistance.';
    }

    // Default fallback response
    return 'I\'m sorry, I\'m experiencing some technical difficulties and can\'t provide a proper response right now. Please try again later or use the app\'s navigation menu to find what you need.';
  }

  /// Clear conversation history (useful for starting fresh conversations)
  void clearConversation() {
    if (_isInitialized && core.AIService.instance.isReady) {
      core.AIService.instance.clearConversation(_conversationId);
      _conversationId = core.AIService.instance.generateConversationId();
    }
  }

  /// Get conversation history
  List<core.AIConversationItem> getConversationHistory() {
    if (_isInitialized && core.AIService.instance.isReady) {
      return core.AIService.instance.getConversationHistory(_conversationId);
    }
    return [];
  }

  /// Check if AI service is ready
  bool get isReady => _isInitialized && core.AIService.instance.isReady;

  /// Get current conversation ID
  String get conversationId => _conversationId;
}

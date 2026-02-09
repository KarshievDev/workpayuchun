import 'dart:async';
import 'package:core/core.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:get_it/get_it.dart';
import 'package:event_bus_plus/event_bus_plus.dart';

/// Main AI service for handling AI interactions in the HRM app
class AIService {
  static AIService? _instance;

  static AIService get instance => _instance ??= AIService._();

  AIService._();

  GenerativeModel? _model;
  AIConfiguration? _configuration;
  final Map<String, List<AIConversationItem>> _conversations = {};
  final Map<String, Timer> _conversationTimers = {};

  /// Event bus for AI events
  EventBus get _eventBus => GetIt.instance.get<EventBus>();

  /// Initialize AI service with configuration
  Future<void> initialize(AIConfiguration configuration) async {
    _configuration = configuration;

    try {
      _model = GenerativeModel(
        model: configuration.model,
        apiKey: configuration.apiKey,
        generationConfig: GenerationConfig(
          temperature: configuration.temperature,
          maxOutputTokens: configuration.maxTokens,
        ),
      );

      // Listen to global data updates for context refresh
      _eventBus.on<GlobalDataUpdateEvent>().listen(_onGlobalDataUpdate);
    } catch (e) {
      throw AIServiceException(
        'Failed to initialize AI service: ${e.toString()}',
      );
    }
  }

  /// Process AI query with current context
  Future<AIResponse> processQuery(AIRequest request) async {
    if (_model == null || _configuration == null) {
      return AIResponse.error(error: 'AI service not initialized');
    }

    try {
      // Auto-detect query type if not specified
      final queryType =
          request.queryType == AIQueryType.general
              ? AIPromptBuilder.detectQueryType(request.query)
              : request.queryType;

      // Get current data context
      final currentData = AIDataFormatter.getCurrentDataSnapshot();

      // Create enhanced request with current data
      final enhancedRequest = AIRequest(
        query: request.query,
        homeData: request.homeData ?? currentData['home'],
        leaveData: request.leaveData ?? currentData['leave'],
        authenticationData:
            request.authenticationData ?? currentData['authentication'],
        context: request.context,
        conversationId: request.conversationId,
        queryType: queryType,
      );

      // Build appropriate prompt
      String prompt;
      if (request.conversationId != null &&
          _conversations.containsKey(request.conversationId)) {
        // Continue existing conversation
        prompt = AIPromptBuilder.buildConversationPrompt(
          request.query,
          _conversations[request.conversationId]!,
          currentData,
        );
      } else {
        prompt = AIPromptBuilder.buildPrompt(enhancedRequest);
      }

      // Generate AI response
      final response = await _model!.generateContent([Content.text(prompt)]);
      final responseText = response.text ?? 'No response generated';

      // Create successful response
      final aiResponse = AIResponse.success(
        response: responseText,
        conversationId: request.conversationId,
        metadata: {
          'queryType': queryType.name,
          'hasHomeData': currentData['home'] != null,
          'hasLeaveData': currentData['leave'] != null,
          'hasAuthenticationData': currentData['authentication'] != null,
          'dataTimestamp': currentData['timestamp'],
        },
      );

      // Store conversation history if enabled
      if (_configuration!.enableConversationMemory &&
          request.conversationId != null) {
        _storeConversationItem(
          request.conversationId!,
          request.query,
          responseText,
          queryType,
          currentData,
        );
      }

      return aiResponse;
    } catch (e) {
      return AIResponse.error(
        error: 'Failed to process query: ${e.toString()}',
        conversationId: request.conversationId,
      );
    }
  }

  /// Process quick action query
  Future<AIResponse> processQuickAction(
    String action, {
    String? conversationId,
  }) async {
    final currentData = AIDataFormatter.getCurrentDataSnapshot();

    final request = AIRequest(
      query: action,
      queryType: AIQueryType.quickActions,
      homeData: currentData['home'],
      leaveData: currentData['leave'],
      authenticationData: currentData['authentication'],
      conversationId: conversationId,
    );

    return processQuery(request);
  }

  /// Get conversation history
  List<AIConversationItem> getConversationHistory(String conversationId) {
    return _conversations[conversationId] ?? [];
  }

  /// Clear conversation history
  void clearConversation(String conversationId) {
    _conversations.remove(conversationId);
    _conversationTimers[conversationId]?.cancel();
    _conversationTimers.remove(conversationId);
  }

  /// Clear all conversations
  void clearAllConversations() {
    _conversations.clear();
    for (final timer in _conversationTimers.values) {
      timer.cancel();
    }
    _conversationTimers.clear();
  }

  /// Update AI configuration
  Future<void> updateConfiguration(AIConfiguration configuration) async {
    await initialize(configuration);
  }

  /// Check if AI service is ready
  bool get isReady => _model != null && _configuration != null;

  /// Get current configuration
  AIConfiguration? get configuration => _configuration;

  /// Store conversation item in history
  void _storeConversationItem(
    String conversationId,
    String query,
    String response,
    AIQueryType queryType,
    Map<String, dynamic> context,
  ) {
    if (!_conversations.containsKey(conversationId)) {
      _conversations[conversationId] = [];
    }

    final item = AIConversationItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      query: query,
      response: response,
      timestamp: DateTime.now(),
      queryType: queryType,
      context: context,
    );

    _conversations[conversationId]!.add(item);

    // Limit conversation history to prevent memory issues
    if (_conversations[conversationId]!.length > 20) {
      _conversations[conversationId] = _conversations[conversationId]!.sublist(
        10,
      );
    }

    // Reset conversation timeout
    _resetConversationTimeout(conversationId);
  }

  /// Reset conversation timeout
  void _resetConversationTimeout(String conversationId) {
    _conversationTimers[conversationId]?.cancel();

    if (_configuration != null) {
      _conversationTimers[conversationId] = Timer(
        _configuration!.conversationTimeout,
        () => clearConversation(conversationId),
      );
    }
  }

  /// Handle global data updates
  void _onGlobalDataUpdate(GlobalDataUpdateEvent event) {
    // Refresh context for active conversations
    // This ensures AI has the latest data context
  }

  /// Generate conversation ID
  String generateConversationId() {
    return 'conv_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Dispose resources
  void dispose() {
    clearAllConversations();
    _model = null;
    _configuration = null;
  }
}

/// Exception thrown by AI service
class AIServiceException implements Exception {
  final String message;

  const AIServiceException(this.message);

  @override
  String toString() => 'AIServiceException: $message';
}

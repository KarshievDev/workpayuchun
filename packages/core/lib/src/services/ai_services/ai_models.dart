import 'package:equatable/equatable.dart';

/// Request model for AI queries
class AIRequest extends Equatable {
  final String query;
  final Map<String, dynamic>? homeData;
  final Map<String, dynamic>? leaveData;
  final Map<String, dynamic>? authenticationData;
  final Map<String, dynamic>? context;
  final String? conversationId;
  final AIQueryType queryType;

  const AIRequest({
    required this.query,
    this.homeData,
    this.leaveData,
    this.authenticationData,
    this.context,
    this.conversationId,
    this.queryType = AIQueryType.general,
  });

  @override
  List<Object?> get props => [
        query,
        homeData,
        leaveData,
        authenticationData,
        context,
        conversationId,
        queryType,
      ];

  Map<String, dynamic> toJson() => {
        'query': query,
        'homeData': homeData,
        'leaveData': leaveData,
        'authenticationData': authenticationData,
        'context': context,
        'conversationId': conversationId,
        'queryType': queryType.name,
      };
}

/// Response model for AI queries
class AIResponse extends Equatable {
  final String response;
  final bool isSuccess;
  final String? error;
  final Map<String, dynamic>? metadata;
  final String? conversationId;
  final DateTime timestamp;
  final AIResponseType responseType;

  const AIResponse({
    required this.response,
    required this.isSuccess,
    this.error,
    this.metadata,
    this.conversationId,
    required this.timestamp,
    this.responseType = AIResponseType.text,
  });

  @override
  List<Object?> get props => [
        response,
        isSuccess,
        error,
        metadata,
        conversationId,
        timestamp,
        responseType,
      ];

  factory AIResponse.success({
    required String response,
    String? conversationId,
    Map<String, dynamic>? metadata,
    AIResponseType responseType = AIResponseType.text,
  }) {
    return AIResponse(
      response: response,
      isSuccess: true,
      conversationId: conversationId,
      metadata: metadata,
      timestamp: DateTime.now(),
      responseType: responseType,
    );
  }

  factory AIResponse.error({
    required String error,
    String? conversationId,
  }) {
    return AIResponse(
      response: '',
      isSuccess: false,
      error: error,
      conversationId: conversationId,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'response': response,
        'isSuccess': isSuccess,
        'error': error,
        'metadata': metadata,
        'conversationId': conversationId,
        'timestamp': timestamp.toIso8601String(),
        'responseType': responseType.name,
      };
}

/// Types of AI queries for better context handling
enum AIQueryType {
  general,
  leaveRelated,
  attendanceRelated,
  dashboardRelated,
  hrPolicy,
  personalInfo,
  reportGeneration,
  quickActions,
}

/// Types of AI responses for UI handling
enum AIResponseType {
  text,
  markdown,
  actionable,
  dataTable,
  chart,
  notification,
}

/// Configuration for AI service
class AIConfiguration extends Equatable {
  final String apiKey;
  final String model;
  final double temperature;
  final int maxTokens;
  final bool enableConversationMemory;
  final Duration conversationTimeout;

  const AIConfiguration({
    required this.apiKey,
    this.model = 'gemini-2.5-flash',
    this.temperature = 0.7,
    this.maxTokens = 2048,
    this.enableConversationMemory = true,
    this.conversationTimeout = const Duration(minutes: 30),
  });

  @override
  List<Object?> get props => [
        apiKey,
        model,
        temperature,
        maxTokens,
        enableConversationMemory,
        conversationTimeout,
      ];

  AIConfiguration copyWith({
    String? apiKey,
    String? model,
    double? temperature,
    int? maxTokens,
    bool? enableConversationMemory,
    Duration? conversationTimeout,
  }) {
    return AIConfiguration(
      apiKey: apiKey ?? this.apiKey,
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      maxTokens: maxTokens ?? this.maxTokens,
      enableConversationMemory:
          enableConversationMemory ?? this.enableConversationMemory,
      conversationTimeout: conversationTimeout ?? this.conversationTimeout,
    );
  }
}

/// Conversation history item
class AIConversationItem extends Equatable {
  final String id;
  final String query;
  final String response;
  final DateTime timestamp;
  final AIQueryType queryType;
  final Map<String, dynamic>? context;

  const AIConversationItem({
    required this.id,
    required this.query,
    required this.response,
    required this.timestamp,
    required this.queryType,
    this.context,
  });

  @override
  List<Object?> get props => [
        id,
        query,
        response,
        timestamp,
        queryType,
        context,
      ];

  Map<String, dynamic> toJson() => {
        'id': id,
        'query': query,
        'response': response,
        'timestamp': timestamp.toIso8601String(),
        'queryType': queryType.name,
        'context': context,
      };

  factory AIConversationItem.fromJson(Map<String, dynamic> json) {
    return AIConversationItem(
      id: json['id'],
      query: json['query'],
      response: json['response'],
      timestamp: DateTime.parse(json['timestamp']),
      queryType: AIQueryType.values.firstWhere(
        (type) => type.name == json['queryType'],
        orElse: () => AIQueryType.general,
      ),
      context: json['context'],
    );
  }
}

/// Context data for AI processing
class AIContextData extends Equatable {
  final Map<String, dynamic> homeData;
  final Map<String, dynamic> leaveData;
  final Map<String, dynamic> authenticationData;
  final Map<String, dynamic> userInfo;
  final DateTime lastUpdated;

  const AIContextData({
    required this.homeData,
    required this.leaveData,
    required this.authenticationData,
    required this.userInfo,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
        homeData,
        leaveData,
        authenticationData,
        userInfo,
        lastUpdated,
      ];

  bool get isStale =>
      DateTime.now().difference(lastUpdated) > const Duration(minutes: 15);

  Map<String, dynamic> toJson() => {
        'homeData': homeData,
        'leaveData': leaveData,
        'authenticationData': authenticationData,
        'userInfo': userInfo,
        'lastUpdated': lastUpdated.toIso8601String(),
      };
}
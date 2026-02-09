import 'dart:convert';
import 'ai_models.dart';

/// Service for building structured prompts for AI models
class AIPromptBuilder {
  static const String _systemPrompt = '''
You are the AI assistant for StrawberryHRM, a Human Resource Management application.  
You have access to real-time user data such as dashboard information, attendance records, leave balances, and user profiles.

Your role is to act as a knowledgeable HR guide, providing clear, accurate, and actionable responses.

Core responsibilities:
1. Answer HR-related questions using the provided context data
2. Explain leave balances, attendance records, and other HR details in simple terms
3. Provide insights or reminders based on the user’s current data
4. Suggest next steps or available actions within the HRM system
5. Communicate in a professional, supportive, and approachable tone

Guidelines:
- **Only use HR context data when the user asks an HR-related question**.  
- For casual conversations (e.g., greetings like "hello", "thanks", "how are you"), respond naturally without showing HR data.  
- Never expose raw field names, variables, or system keys (e.g., "leave_data", "isHR"). Always translate them into user-friendly explanations.  
- If context data is missing, outdated, or unclear, explicitly acknowledge the limitation.  
- Recommend specific in-app actions (e.g., "Submit a new leave request", "Check your attendance log").  
- Keep responses concise and formatted for mobile display (short paragraphs, bullet points, avoid special character, and clear action items).

Available context may include:
- Dashboard information (attendance, tasks, notifications)  
- Leave management data (balances, requests, approvals)  
- User authentication and profile data (name, role, department, permissions)  
- Current date and time context  

Your ultimate goal is to help users manage their HR-related tasks quickly, accurately, and confidently within StrawberryHRM.
''';

  /// Build a complete prompt with system context and user data
  static String buildPrompt(AIRequest request) {
    final buffer = StringBuffer();

    // Add system prompt
    buffer.writeln(_systemPrompt);
    buffer.writeln();

    // Add context data
    buffer.writeln('CURRENT USER CONTEXT:');
    buffer.writeln('========================');

    // Add timestamp
    buffer.writeln('Current DateTime: ${DateTime.now().toIso8601String()}');
    buffer.writeln();

    // Add home data if available
    if (request.homeData != null && request.homeData!.isNotEmpty) {
      buffer.writeln('HOME DASHBOARD DATA:');
      buffer.writeln(
        const JsonEncoder.withIndent('  ').convert(request.homeData),
      );
      buffer.writeln();
    }

    // Add leave data if available
    if (request.leaveData != null && request.leaveData!.isNotEmpty) {
      buffer.writeln('LEAVE MANAGEMENT DATA:');
      buffer.writeln(
        const JsonEncoder.withIndent('  ').convert(request.leaveData),
      );
      buffer.writeln();
    }

    // Add authentication data if available
    if (request.authenticationData != null &&
        request.authenticationData!.isNotEmpty) {
      buffer.writeln('USER AUTHENTICATION DATA:');
      buffer.writeln(
        const JsonEncoder.withIndent('  ').convert(request.authenticationData),
      );
      buffer.writeln();
    }

    // Add additional context if available
    if (request.context != null && request.context!.isNotEmpty) {
      buffer.writeln('ADDITIONAL CONTEXT:');
      buffer.writeln(
        const JsonEncoder.withIndent('  ').convert(request.context),
      );
      buffer.writeln();
    }

    // Add query type context
    buffer.writeln('QUERY TYPE: ${request.queryType.name}');
    buffer.writeln();

    // Add the actual user query
    buffer.writeln('USER QUERY:');
    buffer.writeln('============');
    buffer.writeln(request.query);
    buffer.writeln();

    // Add specific instructions based on query type
    buffer.writeln('RESPONSE INSTRUCTIONS:');
    buffer.writeln(_getResponseInstructions(request.queryType));

    return buffer.toString();
  }

  /// Build a contextual prompt for specific query types
  static String buildContextualPrompt(
    String query,
    AIQueryType queryType,
    Map<String, dynamic>? homeData,
    Map<String, dynamic>? leaveData,
    Map<String, dynamic>? authenticationData,
  ) {
    final request = AIRequest(
      query: query,
      queryType: queryType,
      homeData: homeData,
      leaveData: leaveData,
      authenticationData: authenticationData,
    );
    return buildPrompt(request);
  }

  /// Build a quick action prompt for immediate responses
  static String buildQuickActionPrompt(
    String action,
    Map<String, dynamic> userData,
  ) {
    return '''
$_systemPrompt

USER DATA CONTEXT:
${const JsonEncoder.withIndent('  ').convert(userData)}

QUICK ACTION REQUEST: $action

Provide a brief, actionable response that helps the user complete this action within the StrawberryHRM app.
Focus on specific steps or information they need.
''';
  }

  /// Build conversation continuation prompt
  static String buildConversationPrompt(
    String query,
    List<AIConversationItem> conversationHistory,
    Map<String, dynamic>? currentData,
  ) {
    final buffer = StringBuffer();

    buffer.writeln(_systemPrompt);
    buffer.writeln();

    // Add current data context
    if (currentData != null && currentData.isNotEmpty) {
      buffer.writeln('CURRENT USER CONTEXT:');
      buffer.writeln(const JsonEncoder.withIndent('  ').convert(currentData));
      buffer.writeln();
    }

    // Add conversation history
    if (conversationHistory.isNotEmpty) {
      buffer.writeln('CONVERSATION HISTORY:');
      buffer.writeln('=====================');

      for (final item in conversationHistory.take(5)) {
        // Limit to last 5 exchanges
        buffer.writeln('User: ${item.query}');
        buffer.writeln('Assistant: ${item.response}');
        buffer.writeln('---');
      }
      buffer.writeln();
    }

    buffer.writeln('CURRENT USER QUERY:');
    buffer.writeln(query);
    buffer.writeln();
    buffer.writeln(
      'Continue the conversation naturally, referencing previous context when relevant.',
    );

    return buffer.toString();
  }

  /// Get response instructions based on query type
  static String _getResponseInstructions(AIQueryType queryType) {
    switch (queryType) {
      case AIQueryType.leaveRelated:
        return '''
- Focus on leave balances, requests, and policies
- Mention specific leave types and available days
- Suggest actions like applying for leave or checking status
- Reference current leave requests if any
''';

      case AIQueryType.attendanceRelated:
        return '''
- Focus on attendance records, check-in/out times
- Mention attendance patterns or issues
- Suggest attendance-related actions
- Reference recent attendance data
''';

      case AIQueryType.dashboardRelated:
        return '''
- Focus on dashboard metrics and summaries
- Explain key performance indicators
- Suggest navigation to relevant sections
- Highlight important notifications or alerts
''';

      case AIQueryType.hrPolicy:
        return '''
- Provide clear policy explanations
- Reference company guidelines
- Suggest where to find more detailed information
- Be authoritative but refer to official sources when needed
''';

      case AIQueryType.personalInfo:
        return '''
- Focus on user profile and personal data
- Suggest profile updates or verifications needed
- Reference personal settings and preferences
- Maintain privacy and security awareness
''';

      case AIQueryType.reportGeneration:
        return '''
- Focus on available reports and analytics
- Suggest specific report types based on user role
- Explain how to generate and access reports
- Highlight key metrics and insights
''';

      case AIQueryType.quickActions:
        return '''
- Provide immediate, actionable steps
- Focus on efficiency and ease of use
- List specific buttons or screens to access
- Keep responses concise and direct
''';

      case AIQueryType.general:
      return '''
- Analyze the context data to provide relevant insights
- Be helpful and informative
- Suggest specific actions when appropriate
- Maintain a professional, friendly tone
''';
    }
  }

  /// Extract query type from user query text
  static AIQueryType detectQueryType(String query) {
    final lowerQuery = query.toLowerCase();

    // Leave-related keywords
    if (_containsAny(lowerQuery, [
      'leave',
      'vacation',
      'holiday',
      'sick',
      'absent',
      'off',
      'balance',
      'apply',
      'request',
      'approve',
      'remaining',
    ])) {
      return AIQueryType.leaveRelated;
    }

    // Attendance-related keywords
    if (_containsAny(lowerQuery, [
      'attendance',
      'check in',
      'check out',
      'present',
      'late',
      'early',
      'punch',
      'clock',
      'work hours',
      'overtime',
    ])) {
      return AIQueryType.attendanceRelated;
    }

    // Dashboard-related keywords
    if (_containsAny(lowerQuery, [
      'dashboard',
      'summary',
      'overview',
      'statistics',
      'metrics',
      'performance',
      'status',
      'notification',
    ])) {
      return AIQueryType.dashboardRelated;
    }

    // HR Policy keywords
    if (_containsAny(lowerQuery, [
      'policy',
      'rule',
      'guideline',
      'regulation',
      'procedure',
      'compliance',
      'handbook',
      'documentation',
    ])) {
      return AIQueryType.hrPolicy;
    }

    // Personal info keywords
    if (_containsAny(lowerQuery, [
      'profile',
      'personal',
      'information',
      'details',
      'update',
      'contact',
      'address',
      'phone',
      'email',
    ])) {
      return AIQueryType.personalInfo;
    }

    // Report generation keywords
    if (_containsAny(lowerQuery, [
      'report',
      'analytics',
      'chart',
      'graph',
      'export',
      'download',
      'generate',
      'analysis',
    ])) {
      return AIQueryType.reportGeneration;
    }

    // Quick action keywords
    if (_containsAny(lowerQuery, [
      'how to',
      'where is',
      'show me',
      'find',
      'quick',
      'help',
      'navigate',
      'access',
    ])) {
      return AIQueryType.quickActions;
    }

    return AIQueryType.general;
  }

  /// Helper method to check if query contains any of the keywords
  static bool _containsAny(String query, List<String> keywords) {
    return keywords.any((keyword) => query.contains(keyword));
  }

  /// Build system prompt for specific features
  static String buildFeaturePrompt(String feature, Map<String, dynamic> data) {
    return '''
$_systemPrompt

FEATURE CONTEXT: $feature
USER DATA: ${const JsonEncoder.withIndent('  ').convert(data)}

Provide specific help and information related to the $feature feature in StrawberryHRM.
Focus on practical guidance and current user data.
''';
  }
}

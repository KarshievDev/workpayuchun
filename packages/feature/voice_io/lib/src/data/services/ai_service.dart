import 'dart:math';
import 'package:dio/dio.dart';

abstract class AIService {
  Future<String> generateResponse(String userMessage);
}

class AIServiceImpl implements AIService {
  AIServiceImpl();

  @override
  Future<String> generateResponse(String userMessage) async {
    // For demo purposes, we'll return predefined responses
    // In a real app, you'd integrate with OpenAI, Gemini, or other AI services
    await Future<void>.delayed(const Duration(seconds: 1, milliseconds: 500));

    return _getAIResponse(userMessage);
  }

  String _getAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    // Simple rule-based responses for demo
    if (message.contains('hello') || message.contains('hi')) {
      return _getRandomResponse([
        'Hello! How can I help you today?',
        'Hi there! What would you like to know?',
        'Hey! I\'m here to assist you.',
        'Hello! Ready to chat?',
      ]);
    }

    if (message.contains('how are you')) {
      return _getRandomResponse([
        'I\'m doing great, thanks for asking! How are you?',
        'I\'m functioning perfectly! How can I help you today?',
        'All systems are running smoothly! What\'s on your mind?',
      ]);
    }

    if (message.contains('weather')) {
      return _getRandomResponse([
        'I don\'t have access to real-time weather data, but you can check your local weather app!',
        'For accurate weather information, I recommend checking a weather service.',
        'I wish I could tell you about the weather, but I don\'t have that capability yet.',
      ]);
    }

    if (message.contains('time')) {
      return _getRandomResponse([
        'I don\'t have access to the current time, but you can check your device\'s clock!',
        'Time flies when you\'re having a good conversation! Check your device for the current time.',
        'I can\'t tell time, but I know you can check it on your phone!',
      ]);
    }

    if (message.contains('help')) {
      return _getRandomResponse([
        'I\'m here to help! You can ask me questions, have a conversation, or just chat.',
        'How can I assist you? I\'m ready to help with whatever you need!',
        'I\'m your AI assistant! Feel free to ask me anything.',
      ]);
    }

    if (message.contains('thank')) {
      return _getRandomResponse([
        'You\'re welcome! Happy to help!',
        'My pleasure! Anything else I can help with?',
        'You\'re very welcome! Feel free to ask more questions.',
      ]);
    }

    if (message.contains('joke')) {
      return _getRandomResponse([
        'Why don\'t scientists trust atoms? Because they make up everything!',
        'I told my wife she was drawing her eyebrows too high. She looked surprised.',
        'Why did the scarecrow win an award? He was outstanding in his field!',
        'What do you call a fake noodle? An impasta!',
      ]);
    }

    if (message.contains('work') ||
        message.contains('job') ||
        message.contains('office')) {
      return _getRandomResponse([
        'Work can be challenging but rewarding! What\'s happening at your workplace?',
        'Every job has its ups and downs. How can I help with work-related questions?',
        'Whether it\'s about productivity or workplace issues, I\'m here to help!',
      ]);
    }

    if (message.contains('food') ||
        message.contains('eat') ||
        message.contains('hungry')) {
      return _getRandomResponse([
        'Food is one of life\'s great pleasures! What\'s your favorite cuisine?',
        'I don\'t eat, but I love hearing about delicious meals! What are you craving?',
        'Cooking and eating are such interesting topics! Tell me about your favorite dish.',
      ]);
    }

    // Default responses for general conversation
    return _getRandomResponse([
      'That\'s interesting! Tell me more about it.',
      'I understand. What would you like to explore further?',
      'That\'s a great point! What else is on your mind?',
      'Thanks for sharing that with me. Anything else you\'d like to discuss?',
      'I see what you mean. How can I help you with that?',
      'That sounds important to you. Would you like to elaborate?',
      'Interesting perspective! What made you think about that?',
      'I appreciate you sharing that. What questions do you have?',
      'That\'s worth thinking about. What\'s your take on it?',
      'Good point! I\'d love to hear more of your thoughts.',
    ]);
  }

  String _getRandomResponse(List<String> responses) {
    final random = Random();
    return responses[random.nextInt(responses.length)];
  }
}

// For future integration with real AI services
class OpenAIService implements AIService {
  final Dio _dio;
  final String _apiKey;

  OpenAIService(this._dio, this._apiKey);

  @override
  Future<String> generateResponse(String userMessage) async {
    // Example implementation for OpenAI integration
    // This would require an actual API key and proper error handling
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        'https://api.openai.com/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': userMessage},
          ],
          'max_tokens': 150,
        },
      );

      return response.data?['choices']?[0]?['message']?['content'] as String? ??
          'Sorry, I could not generate a response.';
    } catch (e) {
      rethrow;
    }
  }
}

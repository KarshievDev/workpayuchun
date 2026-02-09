import 'package:shared_preferences/shared_preferences.dart';
import 'ai_models.dart';
import 'ai_service.dart';

/// Manager for AI service configuration and settings
class AIConfigManager {
  static AIConfigManager? _instance;

  static AIConfigManager get instance => _instance ??= AIConfigManager._();

  AIConfigManager._();

  static const String _apiKeyKey = 'ai_api_key';
  static const String _modelKey = 'ai_model';
  static const String _temperatureKey = 'ai_temperature';
  static const String _maxTokensKey = 'ai_max_tokens';
  static const String _conversationMemoryKey = 'ai_conversation_memory';
  static const String _conversationTimeoutKey = 'ai_conversation_timeout';

  SharedPreferences? _prefs;

  /// Initialize configuration manager
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save AI configuration
  Future<void> saveConfiguration(AIConfiguration config) async {
    if (_prefs == null) await initialize();

    await _prefs!.setString(_apiKeyKey, config.apiKey);
    await _prefs!.setString(_modelKey, config.model);
    await _prefs!.setDouble(_temperatureKey, config.temperature);
    await _prefs!.setInt(_maxTokensKey, config.maxTokens);
    await _prefs!.setBool(
      _conversationMemoryKey,
      config.enableConversationMemory,
    );
    await _prefs!.setInt(
      _conversationTimeoutKey,
      config.conversationTimeout.inMinutes,
    );
  }

  /// Load AI configuration
  Future<AIConfiguration?> loadConfiguration() async {
    if (_prefs == null) await initialize();

    final apiKey = _prefs!.getString(_apiKeyKey);
    if (apiKey == null || apiKey.isEmpty) {
      return null;
    }

    return AIConfiguration(
      apiKey: apiKey,
      model: _prefs!.getString(_modelKey) ?? 'gemini-2.5-flash',
      temperature: _prefs!.getDouble(_temperatureKey) ?? 0.7,
      maxTokens: _prefs!.getInt(_maxTokensKey) ?? 2048,
      enableConversationMemory: _prefs!.getBool(_conversationMemoryKey) ?? true,
      conversationTimeout: Duration(
        minutes: _prefs!.getInt(_conversationTimeoutKey) ?? 30,
      ),
    );
  }

  /// Update API key
  Future<void> updateApiKey(String apiKey) async {
    if (_prefs == null) await initialize();
    await _prefs!.setString(_apiKeyKey, apiKey);

    // Reload AI service with updated configuration
    await _reloadAIService();
  }

  /// Update model
  Future<void> updateModel(String model) async {
    if (_prefs == null) await initialize();
    await _prefs!.setString(_modelKey, model);

    await _reloadAIService();
  }

  /// Update temperature
  Future<void> updateTemperature(double temperature) async {
    if (_prefs == null) await initialize();
    await _prefs!.setDouble(_temperatureKey, temperature);

    await _reloadAIService();
  }

  /// Update max tokens
  Future<void> updateMaxTokens(int maxTokens) async {
    if (_prefs == null) await initialize();
    await _prefs!.setInt(_maxTokensKey, maxTokens);

    await _reloadAIService();
  }

  /// Update conversation memory setting
  Future<void> updateConversationMemory(bool enabled) async {
    if (_prefs == null) await initialize();
    await _prefs!.setBool(_conversationMemoryKey, enabled);

    await _reloadAIService();
  }

  /// Update conversation timeout
  Future<void> updateConversationTimeout(Duration timeout) async {
    if (_prefs == null) await initialize();
    await _prefs!.setInt(_conversationTimeoutKey, timeout.inMinutes);

    await _reloadAIService();
  }

  /// Clear configuration
  Future<void> clearConfiguration() async {
    if (_prefs == null) await initialize();

    await _prefs!.remove(_apiKeyKey);
    await _prefs!.remove(_modelKey);
    await _prefs!.remove(_temperatureKey);
    await _prefs!.remove(_maxTokensKey);
    await _prefs!.remove(_conversationMemoryKey);
    await _prefs!.remove(_conversationTimeoutKey);
  }

  /// Check if configuration exists
  Future<bool> hasConfiguration() async {
    if (_prefs == null) await initialize();
    final apiKey = _prefs!.getString(_apiKeyKey);
    return apiKey != null && apiKey.isNotEmpty;
  }

  /// Get current API key (masked for security)
  Future<String?> getMaskedApiKey() async {
    if (_prefs == null) await initialize();
    final apiKey = _prefs!.getString(_apiKeyKey);

    if (apiKey == null || apiKey.isEmpty) return null;

    if (apiKey.length <= 8) return '*' * apiKey.length;

    final start = apiKey.substring(0, 4);
    final end = apiKey.substring(apiKey.length - 4);
    final middle = '*' * (apiKey.length - 8);

    return '$start$middle$end';
  }

  /// Get default configuration
  AIConfiguration getDefaultConfiguration({required String apiKey}) {
    return AIConfiguration(
      apiKey: apiKey,
      model: 'gemini-2.5-flash',
      temperature: 0.7,
      maxTokens: 2048,
      enableConversationMemory: true,
      conversationTimeout: const Duration(minutes: 30),
    );
  }

  /// Get available models
  List<String> getAvailableModels() {
    return ['gemini-2.5-flash', 'gemini-2.5-pro', 'gemini-2.0-flash'];
  }

  /// Validate API key format
  bool isValidApiKey(String apiKey) {
    // Basic validation - Google AI Studio API keys typically start with 'AI'
    return apiKey.isNotEmpty && apiKey.length >= 10;
  }

  /// Reload AI service with current configuration
  Future<void> _reloadAIService() async {
    final config = await loadConfiguration();
    if (config != null && AIService.instance.isReady) {
      await AIService.instance.updateConfiguration(config);
    }
  }

  /// Initialize AI service with saved configuration
  Future<bool> initializeAIService() async {
    final config = await loadConfiguration();
    if (config != null) {
      try {
        await AIService.instance.initialize(config);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  /// Get configuration summary for display
  Future<Map<String, dynamic>> getConfigurationSummary() async {
    final config = await loadConfiguration();
    if (config == null) {
      return {'configured': false};
    }

    return {
      'configured': true,
      'model': config.model,
      'temperature': config.temperature,
      'maxTokens': config.maxTokens,
      'conversationMemory': config.enableConversationMemory,
      'conversationTimeout': '${config.conversationTimeout.inMinutes} minutes',
      'maskedApiKey': await getMaskedApiKey(),
    };
  }
}

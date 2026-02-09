# AI Service Integration

This directory contains AI service implementations for the Voice I/O feature.

## Available AI Services

### 1. AIServiceImpl (Demo/Fallback)
- **File**: `ai_service.dart`
- **Purpose**: Provides demo responses and fallback functionality
- **Usage**: Basic rule-based responses for testing

### 2. GeminiAIService (Production)
- **File**: `gemini_ai_service.dart`
- **Purpose**: Production AI service using Google Gemini via Core AI Service
- **Features**:
  - Context-aware responses using real HRM data
  - Conversation memory
  - Automatic query type detection
  - Integration with home and leave data
  - Fallback to demo responses on error

## Integration Usage

The `VoiceScreen` factory automatically uses `GeminiAIService` which provides:

### Real-time Context
- **Home Data**: Dashboard metrics, notifications, settings
- **Leave Data**: Leave balances, requests, history, types
- **User Info**: Employee details, preferences

### Smart Features
- **Query Classification**: Automatically detects HR-related queries
- **Context-Aware Responses**: Uses current user data for accurate answers
- **Conversation Memory**: Maintains conversation history for follow-ups
- **Voice Integration**: Works seamlessly with speech-to-text input

## Example Interactions

### Leave-Related Queries
```
User: "How many leave days do I have remaining?"
AI: "Based on your current leave balance, you have 15 days remaining out of your total 25 annual leave days. You've used 10 days so far this year."
```

### Attendance Queries
```
User: "Show me my attendance for this month"
AI: "I can see you're looking for attendance information. Please check the Attendance section in your dashboard for detailed monthly reports."
```

### Quick Actions
```
User: "How do I apply for leave?"
AI: "To apply for leave, you can navigate to the Leave section in the app, then tap 'Apply Leave' and select your preferred leave type and dates."
```

## Configuration

The AI service uses the API key configured in the core AI service:
- **Default API Key**: Pre-configured for immediate use
- **Custom Configuration**: Can be updated via `AIConfigManager`
- **Model**: Uses `gemini-2.5-flash` for optimal performance
- **Conversation Memory**: Enabled with 30-minute timeout

## Error Handling

The service includes comprehensive error handling:
1. **Primary**: Google Gemini API responses
2. **Fallback**: HR-focused demo responses
3. **Error States**: User-friendly error messages

## Testing

To test the integration:
1. Open VoiceScreen in the app
2. Type or speak HR-related questions
3. Verify context-aware responses using real data
4. Test conversation memory with follow-up questions

The AI will automatically use your current leave balance, attendance data, and dashboard information to provide personalized responses.
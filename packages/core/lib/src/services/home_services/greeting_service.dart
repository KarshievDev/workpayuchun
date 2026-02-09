import 'dart:math';

/// Service to generate contextual greetings based on user data
class GreetingService {
  /// Generate a personalized greeting message based on available data
  static String generateGreeting({Map<String, dynamic>? userData}) {
    if (userData == null) {
      return _getTimeBasedGreeting();
    }

    // Extract basic greeting from time wish
    String greeting = _extractTimeWish(userData) ?? _getTimeBasedGreeting();

    // Add context based on attendance status
    greeting = _enhanceWithAttendanceContext(greeting, userData);

    // Add break information if relevant
    greeting = _enhanceWithBreakContext(greeting, userData);

    // Add productivity context
    greeting = _enhanceWithProductivityContext(greeting, userData);

    // Add upcoming events context
    greeting = _enhanceWithEventsContext(greeting, userData);

    return greeting;
  }

  /// Generate time-based greeting when no time wish is available
  static String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    final day = DateTime.now().weekday;
    final isWeekend = day == 6 || day == 7; // Saturday or Sunday

    String timeGreeting;
    if (hour < 12) {
      timeGreeting = "Good morning!";
    } else if (hour < 17) {
      timeGreeting = "Good afternoon!";
    } else {
      timeGreeting = "Good evening!";
    }

    // Add contextual messages
    final motivationalMessages = [
      "Ready to make today productive?",
      "Hope you're having a great day!",
      "Let's make today amazing!",
      "Your success story continues today!",
      "Every moment is a fresh beginning!",
    ];

    final weekendMessages = [
      "Enjoy your weekend!",
      "Time to relax and recharge!",
      "Hope you're having a wonderful weekend!",
    ];

    final eveningMessages = [
      "Hope you had a productive day!",
      "Time to wrap up and relax!",
      "Great job on another day!",
    ];

    String message;
    if (isWeekend) {
      message = weekendMessages[hour % weekendMessages.length];
    } else if (hour >= 17) {
      message = eveningMessages[hour % eveningMessages.length];
    } else {
      message = motivationalMessages[hour % motivationalMessages.length];
    }

    return "$timeGreeting $message";
  }

  /// Extract time wish from user data
  static String? _extractTimeWish(Map<String, dynamic> userData) {
    // Try settings first
    final settingsWish = userData['settings']?['time_wish']?['wish'];
    if (settingsWish != null) return settingsWish.toString();

    // Try dashboard config
    final dashboardWish =
        userData['dashboard']?['config']?['time_wish']?['wish'];
    if (dashboardWish != null) return dashboardWish.toString();

    return null;
  }

  /// Enhance greeting with attendance context
  static String _enhanceWithAttendanceContext(
    String greeting,
    Map<String, dynamic> userData,
  ) {
    final attendanceData = userData['dashboard']?['attendance_status'];
    if (attendanceData == null) return greeting;

    final checkIn = attendanceData['checkin'] as bool?;
    final checkout = attendanceData['checkout'] as bool?;
    final stayTime = attendanceData['stay_time'] as String?;

    if (checkIn == true && checkout != true) {
      if (stayTime != null && stayTime.isNotEmpty) {
        return "$greeting You've been here for $stayTime. Keep up the great work!";
      } else {
        return "$greeting You're checked in and ready to go!";
      }
    } else if (checkout == true) {
      return "$greeting You've completed your day. Great job!";
    } else {
      return "$greeting Don't forget to check in when you arrive!";
    }
  }

  /// Enhance greeting with break information
  static String _enhanceWithBreakContext(
    String greeting,
    Map<String, dynamic> userData,
  ) {
    // Check current break status
    final breakStatus =
        userData['settings']?['breakStatus'] ??
        userData['dashboardModel']?['config']?['breakStatus'];

    if (breakStatus?['status'] == "break") {
      return "$greeting You're currently on a break. Take your time to recharge!";
    }

    // Check break history
    final breakHistory = userData['dashboardModel']?['breakHistory'];
    final hasBreak = breakHistory?['hasBreak'] as bool?;
    final totalBreakTime = breakHistory?['time'] as String?;

    if (hasBreak == true &&
        totalBreakTime != null &&
        totalBreakTime.isNotEmpty) {
      return "$greeting You've taken $totalBreakTime of break time today.";
    }

    return greeting;
  }

  /// Enhance greeting with productivity context
  static String _enhanceWithProductivityContext(
    String greeting,
    Map<String, dynamic> userData,
  ) {
    final todayData = userData['dashboard']?['today'] as List?;
    if (todayData == null) return greeting;

    for (final data in todayData) {
      if (data is Map<String, dynamic>) {
        final slug = data['title'] as String?;
        final number = data['number'];

        if (number > 0) {
          return "$greeting,you have $number $slug today!";
        }
      }
    }

    return greeting;
  }

  /// Enhance greeting with upcoming events
  static String _enhanceWithEventsContext(
    String greeting,
    Map<String, dynamic> userData,
  ) {
    final upcomingEvents = userData['dashboard']?['upcoming_events'] as List?;
    if (upcomingEvents == null || upcomingEvents.isEmpty) return greeting;

    final length = upcomingEvents.length;
    final List<Map<String, dynamic>> eventsMap = [];

    for (var event in upcomingEvents) {
      if (event is Map<String, dynamic>) {
        eventsMap.add(event);
      }
    }

    final nextEvent = eventsMap[Random().nextInt(length - 1)];

    final title = nextEvent['title'] as String?;
    final time = nextEvent['time'] as String?;
    final day = nextEvent['day'] as String?;
    final date = nextEvent['start_date'] as String?;

    if (title != null && title.isNotEmpty) {
      return "$greeting '$title' coming up${time != null && time.isNotEmpty ? ' at $time' : ' on $day $date'}!";
    } else {
      return greeting;
    }
  }

  /// Generate a motivational message based on context
  static String generateMotivationalMessage({Map<String, dynamic>? userData}) {
    final messages = [
      "You're doing great! Every small step counts.",
      "Today is full of possibilities. Make it count!",
      "Your dedication doesn't go unnoticed. Keep shining!",
      "Progress happens one task at a time. You've got this!",
      "Your positive attitude makes a difference. Thank you!",
    ];

    // Select message based on current time to ensure variety
    final index = DateTime.now().hour % messages.length;
    return messages[index];
  }

  /// Generate a quick status summary
  static String generateStatusSummary({Map<String, dynamic>? userData}) {
    final hour = DateTime.now().hour;
    final isWeekend = DateTime.now().weekday >= 6;
    final settingsWish = userData?['settings']?['time_wish']?['sub_title'] ?? '';

    // Default messages when no data is available
    final defaultMessages = [
      "Ready to start your day",
      "Let's make today count",
      "Your journey begins now",
      "Time to achieve your goals",
      "Every moment matters",
    ];

    final weekendDefaults = [
      "Enjoy your weekend time",
      "Relax and recharge",
      "Weekend vibes activated",
    ];

    if (userData == null) {
      if (isWeekend) {
        return weekendDefaults[hour % weekendDefaults.length];
      }
      return defaultMessages[hour % defaultMessages.length];
    }

    final attendanceData = userData['dashboard']?['attendance_status'];
    if (attendanceData != null) {
      final checkIn = attendanceData['checkIn'] as bool?;
      final stayTime = attendanceData['stay_time'] as String?;

      if (checkIn == true) {
        if (stayTime != null && stayTime.isNotEmpty) {
          return "Active for $stayTime";
        } else {
          return "You're checked in and ready";
        }
      }
    }

    final todayData = userData['dashboard']?['today'] as List?;
    if (todayData != null) {
      for (final data in todayData) {
        if (data is Map<String, dynamic>) {
          final slug = data['slug'] as String?;
          final number = data['number'];

          if (number > 0) {
            return "You have $number $slug at present";
          }
        }
      }
    }

    // Fallback with time-based context
    if (hour < 9) {
      return "Start your day strong";
    } else {
      return settingsWish;
    }
  }
}


class TimeConstants{
  static const int millisPerSecond = 1000;
  static const int secondPerMinute = 60;
  static const int millisPerMinute = millisPerSecond * secondPerMinute;
  static const int minutesPerHour = 60;
  static const int secondsPerHour = secondPerMinute * minutesPerHour;
  static const int millisPerHour = millisPerMinute * minutesPerHour;
  static const int hoursPerDay = 24;
  static const int minutesPerDay = minutesPerHour * hoursPerDay;
  static const int secondsPerDay = secondsPerHour * hoursPerDay;
  static const int millisPerDay = millisPerHour * hoursPerDay;
  static const int daysPerWeek = 7;
  static const int hoursPerWeek = hoursPerDay * daysPerWeek;
  static const int minutesPerWeek = minutesPerDay * daysPerWeek;
  static const int secondsPerWeek = secondsPerDay * daysPerWeek;
  static const int millisPerWeek = millisPerDay * daysPerWeek;
}
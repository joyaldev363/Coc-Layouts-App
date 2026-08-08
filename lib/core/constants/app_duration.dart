/// AppDuration defines standardized duration for animations and delays.
class AppDuration {
  AppDuration._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  
  static const Duration toastDuration = Duration(seconds: 3);
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

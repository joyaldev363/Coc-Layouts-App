/// AppApi defines all network endpoints and base URLs.
class AppApi {
  AppApi._();

  static const String baseUrl = 'https://api.example.com/v1';
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // User endpoints
  static const String userProfile = '/user/profile';
}

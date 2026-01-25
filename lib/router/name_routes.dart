part of 'routes.dart';

sealed class Routes {
  Routes._();

  ///[auth]
  static const String initial = '/';
  static const String auth = "/auth";
  static const String phonePassword = "/phone-password";
  static const String login = "/login";
  static const String forgotPassword = "/forgot-password";
}

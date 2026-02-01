part of 'routes.dart';

sealed class Routes {
  Routes._();

  /// [auth]
  static const String initial = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  /// [dashboard]
  static const String dashboardOverview = '/dashboard';
  static const String dashboardRealtime = '/dashboard/realtime';
  static const String dashboardThreatSummary = '/dashboard/threat-summary';

  /// [analytics]
  static const String analytics = '/analytics';
  static const String reports = '/analytics/reports';

  /// [threats]
  static const String threatsActive = '/threats';
  static const String threatsResolved = '/threats/resolved';
  static const String threatDetail = '/threats/detail';
  static const String threatTypes = '/threats/types';

  /// [network]
  static const String networkDevices = '/network';
  static const String deviceDetail = '/network/device';
  static const String deviceApiUsage = '/network/api-usage';
  static const String networkProtocols = '/network/protocols';
  static const String networkTrafficLogs = '/network/traffic-logs';

  /// [methods]
  static const String methodAnomaly = '/methods/anomaly';
  static const String methodBehavior = '/methods/behavior';
  static const String methodRule = '/methods/rule';
  static const String methodSignature = '/methods/signature';

  /// [logs]
  static const String logs = '/logs';
  static const String history = '/logs/history';

  /// [settings]
  static const String alerts = '/settings/alerts';
  static const String settingsRules = '/settings/rules';
  static const String userManagement = '/settings/users';
}

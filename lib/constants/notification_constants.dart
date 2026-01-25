/// Notification channel and message constants
class NotificationConstants {
  NotificationConstants._();

  // Channel configuration
  static const String channelId = 'high_importance_channel';
  static const String channelName = 'High Importance Notifications';
  static const String channelDescription =
      'This channel is used for important notifications.';

  // Message data keys
  static const String titleKey = 'title';
  static const String bodyKey = 'body';
  static const String routeKey = 'route';

  // Default values
  static const String defaultTitle = 'Barq';
  static const String defaultBody = 'Sizga yangi xabar keldi';
  static const String defaultIcon = '@mipmap/ic_launcher';
  static const String defaultSound = 'default';
}

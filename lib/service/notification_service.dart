import "dart:async";
import "dart:developer";
import "dart:io";

import "package:corporate_threat_detection/constants/notification_constants.dart";
import "package:corporate_threat_detection/firebase_options.dart";
import "package:corporate_threat_detection/router/routes.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:go_router/go_router.dart";

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

InitializationSettings initializationSettings = const InitializationSettings(
  android: AndroidInitializationSettings(NotificationConstants.defaultIcon),
  iOS: DarwinInitializationSettings(),
);

sealed class NotificationService {
  const NotificationService._();

  static Future<void> initialize() async {
    try {
      if (Firebase.apps.isEmpty) {
        throw StateError(
          'Firebase must be initialized before NotificationService.initialize()',
        );
      }

      final token = await _getFirebaseToken();
      if (token != null) {
        log("FCM TOKEN: $token");
      }

      await setupFlutterNotifications();
      await foregroundNotification();
      backgroundNotification();
      await terminateNotification();

      await _requestAndroidNotificationPermission();
    } on Exception catch (e, s) {
      log("Notification initialization error: $e", stackTrace: s);
      rethrow;
    }
  }

  static Future<String?> _getFirebaseToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } on Exception catch (e, s) {
      log("Firebase getToken error: $e", stackTrace: s);
      return null;
    }
  }
  static Future<void> _requestAndroidNotificationPermission() async {
    if (Platform.isAndroid) {
      try {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      } on Exception catch (e, s) {
        log("Request notification permission error: $e", stackTrace: s);
      }
    }
  }

  static Future<void> setupFlutterNotifications() async {
    try {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission(
          criticalAlert: true,
          announcement: true,
          provisional: true,
        );
      }

      channel = const AndroidNotificationChannel(
        NotificationConstants.channelId,
        NotificationConstants.channelName,
        description: NotificationConstants.channelDescription,
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } on Exception catch (e, s) {
      log("Setup flutter notifications error: $e", stackTrace: s);
    }
  }

  static void showFlutterNotification(RemoteMessage message) {
    if (message.data.isEmpty || kIsWeb) {
      log("Skipping notification: data is empty or running on web");
      return;
    }

    try {
      final title = message.data[NotificationConstants.titleKey] as String? ??
          NotificationConstants.defaultTitle;
      final body = message.data[NotificationConstants.bodyKey] as String? ??
          NotificationConstants.defaultBody;
      final route = message.data[NotificationConstants.routeKey] as String?;

      unawaited(
        flutterLocalNotificationsPlugin.show(
          message.hashCode,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              styleInformation: BigTextStyleInformation(
                body,
                contentTitle: title,
              ),
              icon: NotificationConstants.defaultIcon,
              priority: Priority.high,
              importance: Importance.high,
              visibility: NotificationVisibility.public,
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: NotificationConstants.defaultSound,
            ),
          ),
          payload: route,
        ),
      );
    } on Exception catch (e, s) {
      log("Show notification error: $e", stackTrace: s);
    }
  }

  static Future<void> foregroundNotification() async {
    try {
      FirebaseMessaging.onMessage.listen(showFlutterNotification);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _handleNotificationTap,
      );
    } on Exception catch (e, s) {
      log("Foreground notification setup error: $e", stackTrace: s);
    }
  }

  static void backgroundNotification() {
    try {
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          log("Background notification opened");
          _handleNotificationNavigation(message.data[NotificationConstants.routeKey] as String?);
        },
      );
    } on Exception catch (e, s) {
      log("Background notification setup error: $e", stackTrace: s);
    }
  }

  static Future<void> terminateNotification() async {
    try {
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (remoteMessage != null) {
        log("App opened from terminated state via notification");
        _handleNotificationNavigation(
          remoteMessage.data[NotificationConstants.routeKey] as String?,
        );
      }

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } on Exception catch (e, s) {
      log("Terminate notification setup error: $e", stackTrace: s);
    }
  }

  static void _handleNotificationTap(NotificationResponse response) {
    log("Notification tapped with payload: ${response.payload}");
    _handleNotificationNavigation(response.payload);
  }
  static void _handleNotificationNavigation(String? route) {
    if (route == null || route.isEmpty) {
      log("No route provided in notification");
      return;
    }

    try {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        log("Navigation context is null, cannot navigate");
        return;
      }

      log("Navigating to route: $route");
      if (route.startsWith('/')) {
        context.push(route);
      } else {
        context.pushNamed(route);
      }
    } on Exception catch (e, s) {
      log("Navigation error: $e", stackTrace: s);
    }
  }
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    await NotificationService.setupFlutterNotifications();
    NotificationService.showFlutterNotification(message);
    log("Background message handled: ${message.messageId}");
  } on Exception catch (e, s) {
    log("Background handler error: $e", stackTrace: s);
  }
}

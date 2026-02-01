// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:corporate_threat_detection/core/connectivity/network_info.dart';
import 'package:corporate_threat_detection/injector_container_path.dart';
import 'package:corporate_threat_detection/router/routes.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';






enum AppUpdate { forceUpdate, softUpdate, none }

sealed class RemoteConfigService {
  RemoteConfigService._();

  static final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
static Future<(AppUpdate, String, String)> isCallCheckAppVersion(
  BuildContext context,
  PackageInfo packageInfo,
) async {
  final networkInfo = sl<NetworkInfo>();

  if (await networkInfo.isConnected) {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 5),
        ),
      );

      await remoteConfig.fetchAndActivate();

      RemoteConfigValue? version;
      if (Platform.isAndroid) {
        version = remoteConfig.getAll()[TargetPlatform.android.name];
      } else if (Platform.isIOS) {
        version = remoteConfig.getAll()[TargetPlatform.iOS.name];
      } else if (Platform.isMacOS) {
        version = remoteConfig.getAll()[TargetPlatform.macOS.name];
      }

      final (AppUpdate, String, String) checkResult =
          isNotLastVersion(packageInfo.version, version);

      return checkResult;
    } on Exception catch (e, s) {
      log('Firebase Remote Config error: $e\n$s');
      return (AppUpdate.none, "", "");
    }
  } else {
    await context.pushNamed(Routes.history);
    final PackageInfo packageInfoUpdated = await PackageInfo.fromPlatform();
    return isCallCheckAppVersion(context, packageInfoUpdated);
  }
}


  /// Ilova versiyasi oxirgi versiyadan eski yoki yo‘qligini tekshiradi
  static (AppUpdate, String, String) isNotLastVersion(
    String appVersion,
    RemoteConfigValue? remoteVersion,
  ) {
    if (remoteVersion == null) {
      return (AppUpdate.none, "", "");
    }

    final Map<String, dynamic> remoteMap = jsonDecode(remoteVersion.asString());
    final String latestVersion = remoteMap["version"];
    final bool isForce = remoteMap["is_force"];

    final int remoteInt = int.parse(latestVersion.replaceAll('.', ''));
    final int appInt = int.parse(appVersion.replaceAll('.', ''));

    if (appInt < remoteInt && isForce) {
      return (AppUpdate.forceUpdate, appVersion, latestVersion);
    } else if (appInt < remoteInt && !isForce) {
      return (AppUpdate.softUpdate, appVersion, latestVersion);
    }

    return (AppUpdate.none, "", "");
  }
}

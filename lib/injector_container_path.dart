import 'dart:developer';
import 'dart:io';

import 'package:chuck_interceptor/chuck_interceptor.dart';
import 'package:corporate_threat_detection/constants/constants.dart';
import 'package:corporate_threat_detection/core/connectivity/network_info.dart';
import 'package:corporate_threat_detection/core/database/local_data_source.dart';
import 'package:corporate_threat_detection/core/error/auth_token_interseptor.dart';
import 'package:corporate_threat_detection/router/routes.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:hive/hive.dart';

part 'injector_container.dart';
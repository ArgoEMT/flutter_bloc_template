import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Environment { dev, pprd, production }

class AppConfig {
  AppConfig({
    required this.env,
    required this.appName,
    required this.apiBaseUrl,
    //TODO: Add other config variables here
  });

  AppConfig.fromJson(this.env, Map<String, dynamic> json)
      : appName = json['appName'] as String,
        apiBaseUrl = json['apiBaseUrl'] as String;

  final String apiBaseUrl;
  final String appName;
  final Environment env;

  //TODO: Add other config variables here

  Color get color {
    switch (env) {
      case Environment.dev:
        return Colors.green;
      case Environment.pprd:
        return Colors.orange;
      case Environment.production:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

class ConfigInitializer {
  static Future<AppConfig> initialize(Environment env) async {
    final configString =
        await rootBundle.loadString('configs/app_config_${env.name}.json');

    final configJson = json.decode(configString) as Map<String, dynamic>;

    return AppConfig.fromJson(env, configJson);
  }
}

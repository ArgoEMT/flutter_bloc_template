import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Environment { dev, pprd, production }

class Config {
  Config({
    required this.appName,
    required this.env,
    //TODO: Add other config variables here
  });

  Config.fromJson(this.env, Map<String, dynamic> json)
      : appName = json['appName'] as String;

  final String appName;
  final Environment env;
  //TODO: Add other config variables here
}

class ConfigReader {
  static Config? config;

  static Future initialize(Environment env) async {
    final configString =
        await rootBundle.loadString('configs/app_config_${env.name}.json');

    final configJson = json.decode(configString) as Map<String, dynamic>;

    config = Config.fromJson(env, configJson);
  }

  static String get appName {
    return config?.appName ?? '';
  }

  static Environment get env {
    return config?.env ?? Environment.dev;
  }

  //TODO: Add other config getters here

  static Color get color {
    switch (config?.env) {
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

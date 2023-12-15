import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../config/config_reader.dart';

Future appLogger({
  required String message,
  required String source,
  bool isError = false,
}) async {
  final config = GetIt.I<AppConfig>();
  if (config.env != Environment.dev) {
    if (isError) {
      //TODO: log error to crashlytics (i.e firebase)
    } else {
      //TODO: log to crashlytics (i.e firebase)
    }
  }
  if (kDebugMode) {
    print('$message, name: $source, time: ${DateTime.now()}');
  }
}

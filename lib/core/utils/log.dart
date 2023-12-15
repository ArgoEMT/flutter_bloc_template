import 'package:flutter/foundation.dart';
import '../../config/config_reader.dart';

Future<void> appLogger({
  required String message,
  required String source,
  bool isError = false,
}) async {
  if (ConfigReader.env != Environment.dev) {
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

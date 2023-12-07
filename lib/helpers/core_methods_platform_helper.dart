import 'dart:io' as io;

import 'package:flutter/foundation.dart';

/// Returns true if the platform is iOS
bool get isIOS => !kIsWeb && io.Platform.isIOS;

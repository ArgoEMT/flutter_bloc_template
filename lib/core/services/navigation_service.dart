import 'package:flutter/material.dart';

/// Service that exposes the context
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get context => navigatorKey.currentContext!;
}

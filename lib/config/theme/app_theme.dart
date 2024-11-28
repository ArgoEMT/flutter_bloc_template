import 'package:flutter/material.dart';
import 'app_text_styles.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData defaultTheme = ThemeData(
    //TODO: Change theme
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: appPrimary,
      onPrimary: appWhite,
      secondary: appPrimary,
      onSecondary: appWhite,
      error: appRed,
      onError: appWhite,
      surface: appWhiteF8,
      onSurface: appBlack,
    ),
    textTheme: TextTheme(
      bodySmall: normal12Black,
      bodyMedium: normal14Black,
      bodyLarge: normal16Black,
      labelLarge: bold16Black,
      labelMedium: bold14Black,
      labelSmall: bold12Black,
    ),
  );
}

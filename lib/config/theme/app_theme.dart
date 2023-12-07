import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/config/theme/app_text_styles.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData defaultTheme = ThemeData(
    //TODO: Change theme
    colorScheme: const ColorScheme(
      background: appWhite,
      brightness: Brightness.light,
      primary: appPrimary,
      onPrimary: appWhite,
      secondary: appPrimary,
      onSecondary: appWhite,
      error: appRed,
      onError: appWhite,
      onBackground: appBlack,
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

import 'package:flutter/material.dart';

/// 0xFF1A936F => Primary
const Color appPrimary = Color.fromARGB(255, 149, 96, 167);

/// 0xFF262626 => Noir - Texte
const Color appBlack = Color(0xFF262626);

/// 0x80262626 => Noir avec 50% d'opacité
const Color appBlack50 = Color(0x80262626);

/// 0xB3262626 => Noir avec 70% d'opacité
const Color appBlack70 = Color(0xB3262626);

/// 0xFFFFFFFF => Blanc - Fond
const Color appWhite = Color(0xFFFFFFFF);

/// 0xFFF8F8F8 => Blanc - Fond SearchBar
const Color appWhiteF8 = Color(0xFFF8F8F8);

/// 0xFFD4770A => Orange - En attente/Warning
const Color appOrange = Color(0xFFD4770A);

/// 0xFF9E0F0F => Rouge - Erreur/Danger
const Color appRed = Color(0xFF9E0F0F);

/// 0xFFE5EBF0 => Gris clair - Bordure bouton secondaire
const Color appLightGrey = Color(0xFFE5EBF0);

/// 0xFFC4CCD2 => Gris - Bordure champs/Divider
const Color appGrey = Color(0xFFC4CCD2);

/// 0xFFF0F8EF => Vert clair - Background Homescreen
const Color homeBackgroundColor = Color.fromARGB(20, 149, 96, 167);

extension ColorExtension on Color {
  //? Ce code à été proposé par @mr_mmmmore sur StackOverflow
  //? https://stackoverflow.com/a/60191441

  /// Darken a color by [percent] amount (1 = black)
  // ........................................................
  Color darken([double percent = 0.1]) {
    assert(0.01 <= percent && percent <= 1);
    var f = 1 - percent;
    return Color.fromARGB(
      alpha,
      (red * f).round(),
      (green * f).round(),
      (blue * f).round(),
    );
  }

  /// Lighten a color by [percent] amount (1 = white)
  // ........................................................
  Color lighten([double percent = 0.1]) {
    assert(0.01 <= percent && percent <= 1);

    return Color.fromARGB(
      alpha,
      red + ((255 - red) * percent).round(),
      green + ((255 - green) * percent).round(),
      blue + ((255 - blue) * percent).round(),
    );
  }

  bool get isLight =>
      ThemeData.estimateBrightnessForColor(this) == Brightness.light;
}

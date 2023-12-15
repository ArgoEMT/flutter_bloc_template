import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Color: [alBlack] - FontSize: 12 - FontWeight: 400
const TextStyle normal12Black = TextStyle(
  fontSize: 12,
  color: appBlack,
  fontWeight: FontWeight.w400,
);

/// Color: [appBlack50] - FontSize: 12 - FontWeight: 400
TextStyle normal12Black50 = const TextStyle(
  fontSize: 12,
  color: appBlack50,
  fontWeight: FontWeight.w400,
);

/// Color: [appBlack] - FontSize: 12 - FontWeight: 600
TextStyle bold12Black = const TextStyle(
  fontSize: 12,
  color: appBlack,
  fontWeight: FontWeight.w600,
);

/// Color: [appBlack50] - FontSize: 12 - FontWeight: 600
TextStyle bold12Black50 = const TextStyle(
  fontSize: 12,
  color: appBlack50,
  fontWeight: FontWeight.w600,
);

/// Color: [appPrimary] - FontSize: 12 - FontWeight: 600
const TextStyle bold12Green = TextStyle(
  fontSize: 12,
  color: appPrimary,
  fontWeight: FontWeight.w600,
);

/// Color: [appOrange] - FontSize: 12 - FontWeight: 600
const TextStyle bold12Orange = TextStyle(
  fontSize: 12,
  color: appOrange,
  fontWeight: FontWeight.w600,
);

/// Color: [appRed] - FontSize: 12 - FontWeight: 600
const TextStyle bold12Red = TextStyle(
  fontSize: 12,
  color: appRed,
  fontWeight: FontWeight.w600,
);

// -------------------------------------------- \\\

/// Color: [appBlack] - FontSize: 14 - FontWeight: 400
const normal14Black = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: appBlack,
);

/// Color: [appBlack70] - FontSize: 14 - FontWeight: 400
const normal14Black70 = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: appBlack70,
);

/// Color: [appBlack50] - FontSize: 14 - FontWeight: 400
const normal14Black50 = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: appBlack50,
);

/// Color: [appBlack] - FontSize: 14 - FontWeight: 600
const TextStyle bold14Black = TextStyle(
  fontSize: 14,
  color: appBlack,
  fontWeight: FontWeight.w600,
);

/// Color: [appBlack50] - FontSize: 14 - FontWeight: 600
const TextStyle bold14Black50 = TextStyle(
  fontSize: 14,
  color: appBlack50,
  fontWeight: FontWeight.w600,
);

/// Color: [appPrimary] - FontSize: 14 - FontWeight: 600
const TextStyle bold14Green = TextStyle(
  fontSize: 14,
  color: appPrimary,
  fontWeight: FontWeight.w600,
);

// -------------------------------------------- \\\

/// Color: [appPrimary] - FontSize: 16 - FontWeight: 400
const normal16Green = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: appPrimary,
);

/// Color: [appBlack] - FontSize: 16 - FontWeight: 400
const normal16Black = TextStyle(
  fontSize: 16,
  color: appBlack,
  fontWeight: FontWeight.w400,
);

/// Color: [appBlack50] - FontSize: 16 - FontWeight: 400
const normal16Black50 = TextStyle(
  fontSize: 16,
  color: appBlack50,
  fontWeight: FontWeight.w400,
);

/// Color: [appBlack50] - FontSize: 16 - FontWeight: 600
const bold16Black50 = TextStyle(
  fontSize: 16,
  color: appBlack50,
  fontWeight: FontWeight.w600,
);

/// Color: [appBlack70] - FontSize: 16 - FontWeight: 600
const bold16Black70 = TextStyle(
  fontSize: 16,
  color: appBlack70,
  fontWeight: FontWeight.w600,
);

/// Color: [appBlack] - FontSize: 16 - FontWeight: 600
const bold16Black = TextStyle(
  fontSize: 16,
  color: appBlack,
  fontWeight: FontWeight.w600,
);

/// Color: [appPrimary] - FontSize: 16 - FontWeight: 600
const TextStyle bold16Green = TextStyle(
  fontSize: 16,
  color: appPrimary,
  fontWeight: FontWeight.w600,
);

/// Color: [appWhite] - FontSize: 16 - FontWeight: 600
const TextStyle bold16White = TextStyle(
  fontSize: 16,
  color: appWhite,
  fontWeight: FontWeight.w600,
);

// -------------------------------------------- \\\

/// Color: [appBlack] - FontSize: 20 - FontWeight: 600
const bold20Black = TextStyle(
  fontSize: 20,
  color: appBlack,
  fontWeight: FontWeight.w600,
);

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle withWeight(int weight) {
    if (weight < 0 || weight > 900) {
      return this;
    }
    var tempWeight = (weight / 100).round() - 1;
    if (tempWeight < 0) {
      tempWeight = 0;
    }
    return copyWith(fontWeight: FontWeight.values[tempWeight]);
  }
}

/// Color: [alGreen] - FontSize: 20 - FontWeight: 600
const TextStyle bold20Green = TextStyle(
  fontSize: 20,
  color: appPrimary,
  fontWeight: FontWeight.w600,
);

/// Color: [alOrange] - FontSize: 20 - FontWeight: 600
const TextStyle bold20Orange = TextStyle(
  fontSize: 20,
  color: appOrange,
  fontWeight: FontWeight.w600,
);

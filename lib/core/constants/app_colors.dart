import 'package:flutter/material.dart';

class AppColors {
  // Ana renkler
  static const Color primary = Color(0xFF2C3E50);
  static const Color secondary = Color(0xFF02A0FC);

  // Temel renkler
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
  static const Color orange = Colors.orange;
  static const Color blue = Colors.blue;

  // Arka plan renkleri
  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = white;

  // Metin renkleri
  static const Color text = primary;
  static const Color invontoryText = Color(0xFF2C6BAB);
  static const Color textLight = white;
  static const Color textGrey = Color(0xFF6C7A89);

  // Durum renkleri
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF1C40F);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = secondary;

  // Gölge ve overlay renkleri
  static Color shadowColor = secondary.withAlpha(51); // 0.2 * 255
  static Color overlayColor = secondary.withAlpha(25); // 0.1 * 255

  // Opacity varyasyonları
  static Color get textLightWithOpacity => white.withAlpha(230); // 0.9 * 255
  static Color get textGreyWithOpacity => white.withAlpha(178); // 0.7 * 255

  // Gradient renkler
  static const List<Color> primaryGradient = [
    primary,
    secondary,
  ];
}

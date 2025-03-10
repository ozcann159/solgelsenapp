import 'package:flutter/material.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';

class DrawerTextStyle {
  static const TextStyle MainMenuStyle = TextStyle(
    color: AppColors.textLight,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  static const TextStyle subMenuStyle = TextStyle(
    color: AppColors.textLight,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.normal,
    fontSize: 18,
  );
  static const TextStyle childMenuStyle = TextStyle(
    color: AppColors.textLight,
    fontFamily: 'IBMPlexSans',
    fontWeight: FontWeight.normal,
    fontSize: 17,
  );
}

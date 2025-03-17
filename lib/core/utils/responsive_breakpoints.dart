import 'package:flutter/material.dart';
import 'package:solgensenapp/core/utils/responsive_layout.dart';

class ResponsiveBreakpoints {
  static const double mobile = 650;
  static const double tablet = 1100;
  static const double desktop = 1400;
  
  // Font boyutları
  static double getFontSize(BuildContext context, {
    double mobile = 14,
    double tablet = 16,
    double desktop = 18,
  }) {
    if (ResponsiveLayout.isDesktop(context)) return desktop;
    if (ResponsiveLayout.isTablet(context)) return tablet;
    return mobile;
  }
  
  // Padding değerleri
  static EdgeInsets getPadding(BuildContext context) {
    if (ResponsiveLayout.isDesktop(context)) {
      return const EdgeInsets.all(32);
    }
    if (ResponsiveLayout.isTablet(context)) {
      return const EdgeInsets.all(24);
    }
    return const EdgeInsets.all(16);
  }
  
  // Grid boyutları
  static double getGridSpacing(BuildContext context) {
    if (ResponsiveLayout.isDesktop(context)) return 32;
    if (ResponsiveLayout.isTablet(context)) return 24;
    return 16;
  }
  
  static int getGridCrossAxisCount(BuildContext context) {
    if (ResponsiveLayout.isDesktop(context)) return 4;
    if (ResponsiveLayout.isTablet(context)) return 3;
    return 2;
  }
} 
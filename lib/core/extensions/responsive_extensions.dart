import 'package:flutter/material.dart';
import 'package:solgensenapp/core/utils/responsive_layout.dart';
import 'package:solgensenapp/core/utils/responsive_breakpoints.dart';

extension ResponsiveExtensions on Widget {
  Widget responsive({
    Widget? tablet,
    Widget? desktop,
  }) {
    return ResponsiveLayout(
      mobile: this,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  Widget responsivePadding(BuildContext context) {
    return Padding(
      padding: ResponsiveBreakpoints.getPadding(context),
      child: this,
    );
  }
  
  Widget responsiveWidth(BuildContext context, {
    double mobileWidth = double.infinity,
    double tabletWidth = 650,
    double desktopWidth = 1100,
  }) {
    double maxWidth = mobileWidth;
    if (ResponsiveLayout.isDesktop(context)) {
      maxWidth = desktopWidth;
    } else if (ResponsiveLayout.isTablet(context)) {
      maxWidth = tabletWidth;
    }
    
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: this,
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solgensenapp/core/utils/responsive_breakpoints.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: ResponsiveBreakpoints.getFontSize(
            context,
            mobile: 24,
            tablet: 32,
            desktop: 40,
          ),
        ),
        // Diğer text stilleri...
      ),
      // Diğer tema ayarları...
    );
  }
}
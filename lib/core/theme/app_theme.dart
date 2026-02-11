import 'package:flutter/material.dart';
import 'package:motion_ai/core/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.montserratTextTheme(base.textTheme);
    return base.copyWith(
      scaffoldBackgroundColor: kPrimaryColor,
      textTheme: textTheme.apply(
        bodyColor: const Color(0xffF3F0FF),
        displayColor: const Color(0xffF3F0FF),
      ),
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xffCBB7FF),
        secondary: const Color(0xff7C66C5),
        surface: const Color(0xff1B1430),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xff181228).withOpacity(0.82),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: Color(0xff8F88B3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffF0E7FF),
          foregroundColor: const Color(0xff100B20),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xffE7DCFF),
          side: const BorderSide(color: Color(0x66CBB7FF)),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:authy/core/constants/app_constants.dart';

class AppTheme {
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kPrimaryColor,
        secondary: const Color(0xffE0D7FF),
        surface: const Color(0xffF7F4FF),
      ),
      scaffoldBackgroundColor: const Color(0xffF4F1FB),
      textTheme: base.textTheme.apply(
        fontFamily: kGtSectraFine,
        bodyColor: const Color(0xff1C1A27),
        displayColor: const Color(0xff1C1A27),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xffFFFFFF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

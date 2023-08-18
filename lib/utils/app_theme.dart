import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData init() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.employeePrimary,
      scaffoldBackgroundColor: AppColors.employeeWhite,
      brightness: Brightness.dark,
      textTheme: AppTheme.textTheme(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.employeeWhite,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: AppTheme.inputDecorationTheme(),
    );
  }

  static TextTheme get _textTheme => GoogleFonts.acmeTextTheme();

  static TextTheme textTheme() => TextTheme(
        displaySmall: _textTheme.displaySmall?.copyWith(color: Colors.white),
        headlineSmall: _textTheme.headlineSmall?.copyWith(color: Colors.white),
        titleSmall: _textTheme.titleSmall?.copyWith(color: Colors.white),
        bodySmall: _textTheme.bodySmall?.copyWith(color: Colors.black),
        labelSmall: _textTheme.labelSmall?.copyWith(color: Colors.grey),
      );

  static InputDecorationTheme inputDecorationTheme() => InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 2.w,
        ),
      );
}

class AppExTheme {
  static TextStyle headlineSmall(context) => Theme.of(context).textTheme.headlineSmall!;

  static TextStyle displaySmall(context) => Theme.of(context).textTheme.displaySmall!;

  static TextStyle bodySmall(context) => Theme.of(context).textTheme.bodySmall!;

  static TextStyle titleSmall(context) => Theme.of(context).textTheme.titleSmall!;

  static TextStyle labelSmall(context) => Theme.of(context).textTheme.labelSmall!;
}

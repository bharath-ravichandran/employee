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
      // accentColor: AppColors.alphaError,
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

  // static TextTheme get _headerTextTheme => GoogleFonts.acmeTextTheme();

  static TextStyle? get _headline6 => _textTheme.headline6?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 18.0.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
      );

  static TextStyle? get _headline5 => _textTheme.headline5?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle? get _headline4 => _textTheme.headline5?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 22.0.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle? get _headline3 => _textTheme.headline5?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 24.0.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle? get _headline2 => _textTheme.headline5?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 36.0.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle? get _headline1 => _textTheme.headline5?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 42.0.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle? get _button => _textTheme.button?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 14.sp,
        letterSpacing: 1.25,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );

  static TextStyle? get _bodyText1 => _textTheme.bodyText1?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 16.sp,
        letterSpacing: 0.5,
        height: 1.5,
      );

  static TextStyle? get _bodyText2 => _textTheme.bodyText2?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 14.sp,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle? get _caption => _textTheme.caption?.copyWith(
        color: AppColors.employeeWhite,
        fontSize: 12.sp,
        letterSpacing: 0.4,
        height: 1.5,
      );

  static TextTheme textTheme() => TextTheme(
        headline6: _headline6,
        headline5: _headline5,
        headline4: _headline4,
        headline3: _headline3,
        headline2: _headline2,
        headline1: _headline1,
        bodyText1: _bodyText1,
        bodyText2: _bodyText2,
        button: _button,
        caption: _caption,
      );

  static InputDecorationTheme inputDecorationTheme() => InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 2.w,
        ),
      );
}

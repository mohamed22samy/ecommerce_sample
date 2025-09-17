import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.kPrimaryColor,
    scaffoldBackgroundColor: AppColor.kBgColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.kBgColor,
      titleTextStyle: TextStyle(
        color: AppColor.kFontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColor.kPrimaryColor,
      secondary: AppColor.kGoldColor,
      background: AppColor.kBgColor,
      surface: AppColor.kWhiteColor,
      onPrimary: AppColor.kWhiteColor,
      onSecondary: AppColor.kBlackColor,
      onBackground: AppColor.kBlackColor,
      onSurface: AppColor.kBlackColor,
      onError: AppColor.kRedColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColor.kFontColor),
      bodyMedium: TextStyle(color: AppColor.kGrayColor),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xff4A90A4),
    scaffoldBackgroundColor: const Color(0xff121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff121212),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Color(0xffffffff)),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xff4A90A4),
      secondary: Color(0xffFFD700),
      background: Color(0xff121212),
      surface: Color(0xff1E1E1E),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onSurface: Color(0xffffffff),
      error: Color(0xffFF4757),
      onError: Color(0xffffffff),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xffffffff)),
      bodyMedium: TextStyle(color: Color(0xffB0B0B0)),
      titleLarge: TextStyle(color: Color(0xffffffff)),
      titleMedium: TextStyle(color: Color(0xffffffff)),
      titleSmall: TextStyle(color: Color(0xffB0B0B0)),
    ),
    cardTheme: const CardTheme(
      color: Color(0xff1E1E1E),
      elevation: 4,
    ),
  );
}

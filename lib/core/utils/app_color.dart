import 'package:flutter/material.dart';

import 'app_color_scheme.dart';

class AppColor {
  static const Color kPrimaryColor = Color(0xff015B8A);
  static const Color kPrimaryDarkColor = Color.fromARGB(255, 58, 52, 38);
  static const Color kGoldColor = Color(0xffD0AB52);
  static const Color kWhiteColor = Color(0xffffffff);
  static const Color kBgColor = Color(0xFFFFFFFF);
  static const Color kBgDarkColor = Color(0xff0F2630);
  static const Color kBlackColor = Color(0xff000000);
  static const Color kGrayColor = Color(0xff8A959D);
  static const Color kDarkGrayColor = Color(0xff494949);
  static const Color kDarkBlueColor = Color(0xff1D2B4F);
  static const Color kRedColor = Color(0xffEE1D52);
  static const Color kIconColor = Color(0xff131117);
  static const Color kBorderColor = Color(0xffD3D3D3);
  static const Color kInputPrimaryColor = Color(0xff188d5e);
  static const Color kSecondChartGradientColor = Color(0xff00D083);
  static const Color kFontColor = Color(0xff3D3C3C);
}

class LightAppColor implements AppColorScheme {
  @override
  Color get kPrimaryColor => const Color(0xff143F52);

  @override
  Color get kGoldColor => const Color(0xffD0AB52);

  @override
  Color get kWhiteColor => const Color(0xffffffff);

  @override
  Color get kBgColor => const Color(0xffFCFCFC);

  @override
  Color get kBlackColor => const Color(0xff000000);

  @override
  Color get kGrayColor => const Color(0xff828282);

  @override
  Color get kDarkGrayColor => const Color(0xff494949);

  @override
  Color get kDarkBlueColor => const Color(0xff1D2B4F);

  @override
  Color get kRedColor => const Color(0xffEE1D52);

  @override
  Color get kIconColor => const Color(0xff131117);

  @override
  Color get kBorderColor => const Color(0xffD3D3D3);

  @override
  Color get kInputPrimaryColor => const Color(0xff188d5e);

  @override
  Color get kSecondChartGradientColor => const Color(0xff00D083);

  @override
  Color get kFontColor => const Color(0xff3D3C3C);
  @override
  Color get kInputColor => const Color(0xffF5F5F8);
}

class DarkAppColor implements AppColorScheme {
  @override
  Color get kPrimaryColor => const Color(0xff4A90A4); 

  @override
  Color get kGoldColor => const Color(0xffFFD700); 

  @override
  Color get kWhiteColor => const Color(0xff1E1E1E); 

  @override
  Color get kBgColor => const Color(0xff121212); 

  @override
  Color get kBlackColor => const Color(0xffffffff);

  @override
  Color get kGrayColor => const Color(0xffB0B0B0); 

  @override
  Color get kDarkGrayColor => const Color(0xff707070); 

  @override
  Color get kDarkBlueColor => const Color(0xff2A3F5F); 

  @override
  Color get kRedColor => const Color(0xffFF4757); 

  @override
  Color get kIconColor => const Color(0xffffffff); 

  @override
  Color get kBorderColor => const Color(0xff404040);

  @override
  Color get kInputPrimaryColor => const Color(0xff4CAF50); 

  @override
  Color get kSecondChartGradientColor => const Color(0xff00D083); 

  @override
  Color get kFontColor => const Color(0xffffffff); 

  @override
  Color get kInputColor => const Color(0xff2A2A2A); 
}

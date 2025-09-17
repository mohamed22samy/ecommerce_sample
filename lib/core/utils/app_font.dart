import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppFont{
  
static TextStyle kFontManropeStyle =GoogleFonts.manrope(
    color:  AppColor.kBlackColor,
    fontWeight:  FontWeight.w500,
    fontSize: 14.sp ,
    decoration: TextDecoration.none,
  );
}


class ManropeText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double fontSize;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextDecoration? textDecoration;

  const ManropeText(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.textOverflow,
      this.maxLines,
      this.textDecoration,
      required this.fontSize,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr(),
      overflow: textOverflow,
      maxLines: maxLines,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.center,
      style: GoogleFonts.manrope(
        
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize.sp,
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }
}
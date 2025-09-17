import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_sample/core/utils/app_color.dart';
import 'package:ecommerce_sample/core/utils/app_font.dart';

import '../../utils/app_string.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final bool isLoading;

  const Button({super.key, required this.onPress, required this.title,required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 334.w,
        height: 54.h,
        decoration: BoxDecoration(
            color: AppColor.kPrimaryColor,
            borderRadius: BorderRadius.circular(8.r),
            border:Border.all(color: AppColor.kPrimaryColor,width: 2.w)
        ),
        child:  Center(
          child:isLoading
              ? const CircularProgressIndicator(
              color: AppColor.kWhiteColor)
              : ManropeText(text: title, fontSize: 16,fontWeight: FontWeight.w600,color: AppColor.kWhiteColor,) ,
        ),
      ),
    );
  }
}

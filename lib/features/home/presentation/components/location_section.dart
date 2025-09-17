import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_font.dart';
import '../../../../core/utils/app_string.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        border:
            Border.all(color: Color.fromARGB(255, 220, 222, 223), width: 1.5),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: Color(0xFF1F1F1F0A),
              border: Border.all(
                  color: Color.fromARGB(255, 220, 222, 223), width: 1.5),
              borderRadius: BorderRadius.circular(60.r),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: AppColor.kBlackColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ManropeText(
                text: AppString.sendTo,
                fontSize: 12,
                color: AppColor.kGrayColor,
                fontWeight: FontWeight.w400,
              ),
              ManropeText(
                text: AppString.location,
                fontSize: 14,
                color: AppColor.kBlackColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 40.h,
            width: 92.w,
            decoration: BoxDecoration(
              color: AppColor.kPrimaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: ManropeText(
                text: AppString.change,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

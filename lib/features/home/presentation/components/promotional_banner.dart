import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_font.dart';
import '../../../../core/utils/app_image.dart';
import '../../../../core/utils/app_string.dart';

class PromotionalBanner extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final Function(int) onPageChanged;

  const PromotionalBanner({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChanged,
  });

  List<Map<String, dynamic>> get bannerData => [
        {
          'title': AppString.fiftyOffToday,
          'subtitle1': AppString.limitedTimePicks,
          'subtitle2': AppString.justForYou,
          'buttonText': AppString.shopNow,
          'colors': [
            AppColor.kPrimaryColor,
            Color.fromARGB(255, 114, 154, 200),
            Color.fromARGB(255, 216, 232, 239),
          ],
        },
        {
          'title': AppString.fiftyOffToday,
          'subtitle1': AppString.limitedTimePicks,
          'subtitle2': AppString.justForYou,
          'buttonText': AppString.shopNow,
          'colors': [
            AppColor.kPrimaryColor,
            Color.fromARGB(255, 114, 154, 200),
            Color.fromARGB(255, 216, 232, 239),
          ],
        },
        {
          'title': AppString.fiftyOffToday,
          'subtitle1': AppString.limitedTimePicks,
          'subtitle2': AppString.justForYou,
          'buttonText': AppString.shopNow,
          'colors': [
            AppColor.kPrimaryColor,
            Color.fromARGB(255, 114, 154, 200),
            Color.fromARGB(255, 216, 232, 239),
          ],
        },
      ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 163.h,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: bannerData.length,
        itemBuilder: (context, index) {
          final data = bannerData[index];
          return _buildBannerItem(data);
        },
      ),
    );
  }

  Widget _buildBannerItem(Map<String, dynamic> data) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 151.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: data['colors'],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 0.4, 1.0],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20.w,
                  top: 15.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManropeText(
                        text: data['title'],
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 6.5.h),
                      ManropeText(
                        text: data['subtitle1'],
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                      ),
                      ManropeText(
                        text: data['subtitle2'],
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 10.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 5.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: ManropeText(
                          text: data['buttonText'],
                          fontSize: 14,
                          color: data['colors'][0],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0.w,
          top: -0.h,
          child: SizedBox(
            width: 241.w,
            height: 163.h,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              ),
              child: Image.asset(
                AppImage.kmenFashionImage,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

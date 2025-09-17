import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_icon.dart';

class HomeHeader extends StatelessWidget {
  final bool isSearchExpanded;
  final Animation<double> widthAnimation;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final VoidCallback onSearchToggle;
  final int cartItemCount;
  final VoidCallback onCartPressed;

  const HomeHeader({
    super.key,
    required this.isSearchExpanded,
    required this.widthAnimation,
    required this.searchController,
    required this.searchFocusNode,
    required this.onSearchToggle,
    required this.cartItemCount,
    required this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(AppIcon.klogo),
        Row(
          children: [
            AnimatedBuilder(
              animation: widthAnimation,
              builder: (context, child) {
                return GestureDetector(
                  onTap: onSearchToggle,
                  child: Container(
                    width: widthAnimation.value.w,
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.kBorderColor,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppIcon.kSearch,
                          height: 22.h,
                          width: 22.w,
                          color: AppColor.kBlackColor,
                        ),
                        if (isSearchExpanded) ...[
                          SizedBox(width: 8.w),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              focusNode: searchFocusNode,
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.kGrayColor,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColor.kBlackColor,
                              ),
                              onSubmitted: (value) {
                                onSearchToggle();
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: onSearchToggle,
                            child: Icon(
                              Icons.close,
                              size: 22.sp,
                              color: AppColor.kGrayColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 8.w),
            InkWell(
              onTap: onCartPressed,
              child: Stack(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 220, 222, 223), width: 1.5),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: SizedBox(
                        height: 10.h,
                        width: 10.w,
                        child: SvgPicture.asset(
                          AppIcon.kbag,
                          height: 10.h,
                          width: 10.w,
                          color: AppColor.kBlackColor,
                        )),
                  ),
                  if (cartItemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppColor.kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 20.w,
                          minHeight: 20.h,
                        ),
                        child: Text(
                          cartItemCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

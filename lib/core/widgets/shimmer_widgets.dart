import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/app_color.dart';

class ShimmerWidgets {
  static Widget buildShimmerContainer({
    required double width,
    required double height,
    BorderRadius? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  static Widget buildHeaderShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 21.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildShimmerContainer(
                width: 40.w,
                height: 40.h,
                borderRadius: BorderRadius.circular(8.r),
              ),
              Row(
                children: [
                  buildShimmerContainer(
                    width: 48.w,
                    height: 48.h,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  SizedBox(width: 12.w),
                  buildShimmerContainer(
                    width: 200.w,
                    height: 48.h,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ],
              ),
              buildShimmerContainer(
                width: 48.w,
                height: 48.h,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              buildShimmerContainer(
                width: 24.w,
                height: 24.h,
                borderRadius: BorderRadius.circular(12.r),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmerContainer(
                    width: 60.w,
                    height: 12.h,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  SizedBox(height: 4.h),
                  buildShimmerContainer(
                    width: 140.w,
                    height: 14.h,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ],
              ),
              const Spacer(),
              buildShimmerContainer(
                width: 92.w,
                height: 40.h,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildBannerShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: buildShimmerContainer(
        width: double.infinity,
        height: 163.h,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
    );
  }

  static Widget buildBrandsShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildShimmerContainer(
                width: 120.w,
                height: 20.h,
                borderRadius: BorderRadius.circular(10.r),
              ),
              buildShimmerContainer(
                width: 60.w,
                height: 16.h,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: buildShimmerContainer(
                    width: 80.w,
                    height: 40.h,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFlashSaleShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildShimmerContainer(
                width: 100.w,
                height: 20.h,
                borderRadius: BorderRadius.circular(10.r),
              ),
              buildShimmerContainer(
                width: 60.w,
                height: 16.h,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.75,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmerContainer(
                    width: double.infinity,
                    height: 160.h,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  SizedBox(height: 8.h),
                  buildShimmerContainer(
                    width: double.infinity,
                    height: 16.h,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  SizedBox(height: 4.h),
                  buildShimmerContainer(
                    width: 80.w,
                    height: 14.h,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget buildFullPageShimmer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildHeaderShimmer(),
          SizedBox(height: 12.h),
          buildBannerShimmer(),
          SizedBox(height: 16.5.h),
          buildBrandsShimmer(),
          SizedBox(height: 17.5.h),
          buildFlashSaleShimmer(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  static Widget buildImageWithShimmer({
    required String imagePath,
    required double width,
    required double height,
    BorderRadius? borderRadius,
    BoxFit fit = BoxFit.cover,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      child: Stack(
        children: [
          buildShimmerContainer(
            width: width,
            height: height,
            borderRadius: borderRadius,
          ),
          Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return buildShimmerContainer(
                width: width,
                height: height,
                borderRadius: borderRadius,
              );
            },
          ),
        ],
      ),
    );
  }
}

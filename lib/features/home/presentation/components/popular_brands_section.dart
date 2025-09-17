import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_font.dart';
import '../../../../core/utils/app_image.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../controller/home_state.dart';

class PopularBrandsSection extends StatelessWidget {
  final HomeState state;

  const PopularBrandsSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ManropeText(
          text: "Popular Brand",
          fontSize: 20,
          color: AppColor.kBlackColor,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 21.h),
        SizedBox(
          height: 110.h,
          child: _buildCategoriesList(),
        ),
      ],
    );
  }

  Widget _buildCategoriesList() {
    if (state.categoriesStatus == RequestStatus.loaded &&
        state.categories.isNotEmpty) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          final category = state.categories[index];
          return Container(
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                Container(
                  width: 72.w,
                  height: 72.h,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Image.asset(AppImage.kZaraLogoImage),
                ),
                SizedBox(height: 17.h),
                SizedBox(
                  width: 72.w,
                  child: ManropeText(
                    text: _formatCategoryName(category.name),
                    fontSize: 14,
                    color: Color(0xFF1F1F1F),
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    final defaultBrands = [
      {"name": "H&M", "color": Colors.red},
      {"name": "Zara", "color": Colors.black},
      {"name": "Lacoste", "color": Colors.green},
      {"name": "Ralph L", "color": Colors.red},
      {"name": "Pull & B", "color": Colors.red},
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: defaultBrands.length,
      itemBuilder: (context, index) {
        final brand = defaultBrands[index];
        return Container(
          margin: EdgeInsets.only(right: 16.w),
          child: Column(
            children: [
              Container(
                width: 72.w,
                height: 72.h,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: state.categoriesStatus == RequestStatus.loading
                    ? ShimmerWidgets.buildShimmerContainer(
                        width: 52.w,
                        height: 52.h,
                        borderRadius: BorderRadius.circular(26.r),
                      )
                    : Image.asset(AppImage.kZaraLogoImage),
              ),
              SizedBox(height: 17.h),
              state.categoriesStatus == RequestStatus.loading
                  ? ShimmerWidgets.buildShimmerContainer(
                      width: 60.w,
                      height: 14.h,
                      borderRadius: BorderRadius.circular(7.r),
                    )
                  : ManropeText(
                      text: brand["name"] as String,
                      fontSize: 14,
                      color: Color(0xFF1F1F1F),
                      fontWeight: FontWeight.w500,
                    ),
            ],
          ),
        );
      },
    );
  }

  String _formatCategoryName(String categoryName) {
    return categoryName
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

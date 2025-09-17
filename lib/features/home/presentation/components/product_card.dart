import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_font.dart';
import '../../../../core/utils/app_image.dart';
import '../../../../core/widgets/shimmer_widgets.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String oldPrice;
  final String rating;
  final Color bgColor;
  final String imageUrl;
  final int? productId;
  final Function(String, String, String, Color, int?) onAddToCart;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.bgColor,
    required this.imageUrl,
    this.productId,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 177.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 177.h,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return ShimmerWidgets.buildShimmerContainer(
                            width: double.infinity,
                            height: 177.h,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return ShimmerWidgets.buildImageWithShimmer(
                            imagePath: AppImage.kflashSaleImage,
                            width: double.infinity,
                            height: 177.h,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () => onAddToCart(title, price, imageUrl, bgColor, productId),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 18.sp,
                        color: AppColor.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14.5.h),
              Row(
                children: [
                  SizedBox(width: 4.w),
                  SizedBox(
                    width: 160.w,
                    child: ManropeText(
                      text: title,
                      fontSize: 14,
                      color: AppColor.kBlackColor,
                      fontWeight: FontWeight.w400,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  SizedBox(width: 4.w),
                ],
              ),
              SizedBox(height: 2.5.h),
              Row(
                children: [
                  SizedBox(width: 4.w),
                  ManropeText(
                    text: price,
                    fontSize: 16,
                    color: AppColor.kBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 8.w),
                  ManropeText(
                    text: oldPrice,
                    fontSize: 12,
                    color: AppColor.kGrayColor,
                    fontWeight: FontWeight.w300,
                    textDecoration: TextDecoration.lineThrough,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16.sp,
                      ),
                      SizedBox(width: 2.w),
                      ManropeText(
                        text: rating,
                        fontSize: 12,
                        color: AppColor.kGrayColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(width: 4.w),
                ],
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ],
      ),
    );
  }
}

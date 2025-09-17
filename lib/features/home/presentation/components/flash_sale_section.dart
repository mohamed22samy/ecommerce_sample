import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_font.dart';
import '../../../../core/utils/app_image.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../controller/home_state.dart';
import 'product_card.dart';

class FlashSaleSection extends StatelessWidget {
  final HomeState state;
  final Function(String, String, String, Color, int?) onAddToCart;

  const FlashSaleSection({
    super.key,
    required this.state,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ManropeText(
              text: "Flash Sale",
              fontSize: 20,
              color: AppColor.kBlackColor,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                ManropeText(
                  text: "Ends at",
                  fontSize: 14,
                  color: Color.fromARGB(255, 66, 72, 76),
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFE62B3B),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ManropeText(
                    text: "1 : 24 : 02",
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildProductsGrid(),
      ],
    );
  }

  Widget _buildProductsGrid() {
    if (state.productsStatus == RequestStatus.loaded &&
        state.products.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 0.75,
        ),
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];
          return ProductCard(
            title: product.title,
            price: "\$${product.price.toStringAsFixed(2)}",
            oldPrice: "",
            rating: product.rating.rate.toStringAsFixed(1),
            bgColor: _getProductColor(index),
            imageUrl: product.image,
            productId: product.id,
            onAddToCart: onAddToCart,
          );
        },
      );
    }

    final defaultProducts = [
      {
        "title": "Puff Sleeved Blouse",
        "price": "\$16.99",
        "oldPrice": "\$27.99",
        "rating": "4.9",
        "color": Colors.blue.shade100,
      },
      {
        "title": "Printed T-Shirt",
        "price": "\$11.99",
        "oldPrice": "\$19.99",
        "rating": "4.8",
        "color": AppColor.kPrimaryColor,
      },
      {
        "title": "Cotton Shirt",
        "price": "\$24.99",
        "oldPrice": "\$35.99",
        "rating": "4.7",
        "color": Colors.grey.shade200,
      },
      {
        "title": "Casual Polo",
        "price": "\$19.99",
        "oldPrice": "\$29.99",
        "rating": "4.6",
        "color": Colors.blue.shade200,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final product = defaultProducts[index];

        if (state.productsStatus == RequestStatus.loading) {
          return _buildProductShimmer();
        }

        return ProductCard(
          title: product["title"] as String,
          price: product["price"] as String,
          oldPrice: product["oldPrice"] as String,
          rating: product["rating"] as String,
          bgColor: product["color"] as Color,
          imageUrl: AppImage.kflashSaleImage,
          productId: index + 1000,
          onAddToCart: onAddToCart,
        );
      },
    );
  }

  Widget _buildProductShimmer() {
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
          ShimmerWidgets.buildShimmerContainer(
            width: double.infinity,
            height: 177.h,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidgets.buildShimmerContainer(
                  width: 120.w,
                  height: 14.h,
                  borderRadius: BorderRadius.circular(7.r),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    ShimmerWidgets.buildShimmerContainer(
                      width: 60.w,
                      height: 16.h,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    Spacer(),
                    ShimmerWidgets.buildShimmerContainer(
                      width: 40.w,
                      height: 14.h,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getProductColor(int index) {
    final colors = [
      Colors.blue.shade100,
      AppColor.kPrimaryColor,
      Colors.grey.shade200,
      Colors.blue.shade200,
      Colors.green.shade100,
      Colors.orange.shade100,
    ];
    return colors[index % colors.length];
  }
}

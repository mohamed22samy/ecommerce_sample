import 'package:ecommerce_sample/core/utils/app_color.dart';
import 'package:ecommerce_sample/core/utils/app_font.dart';
import 'package:ecommerce_sample/core/utils/app_image.dart';
import 'package:ecommerce_sample/core/utils/app_string.dart';
import 'package:ecommerce_sample/core/services/cart_service.dart';
import 'package:ecommerce_sample/core/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class CardScreen extends StatefulWidget {
  final String sourseScreen;
  const CardScreen({super.key, required this.sourseScreen});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<CartItemModel> cartItems = [];
  bool isLoading = true;

  double get subtotal =>
      cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  double get shippingFee => 0.00;
  double get taxes => 0.00;
  double get total => subtotal + shippingFee + taxes;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final items = await CartService.instance.getCartItems();
      setState(() {
        cartItems = items;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.sourseScreen == "home"
                      ? InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 48.w,
                            height: 48.h,
                            margin: EdgeInsets.all(0.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 220, 222, 223),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColor.kBlackColor,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  ManropeText(
                    text: AppString.cart,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.kBlackColor,
                  ),
                  Container(
                    width: 48.w,
                    height: 48.h,
                    padding: EdgeInsets.all(0.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 220, 222, 223),
                          width: 1.5),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.favorite_border,
                        color: AppColor.kBlackColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : cartItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 80.sp,
                                color: AppColor.kGrayColor,
                              ),
                              SizedBox(height: 16.h),
                              ManropeText(
                                text: AppString.cartEmpty.tr(),
                                fontSize: 18,
                                color: AppColor.kGrayColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              ...cartItems.map((item) => _buildCartItem(item)),

                              SizedBox(height: 24.h),

                              Divider(
                                color: AppColor.kBorderColor,
                              ),
                              SizedBox(height: 21.h),

                              _buildShippingInformation(),
                              SizedBox(height: 20.h),
                              _buildOrderSummary(),
                              SizedBox(height: 47.h),
                              Divider(
                                color: AppColor.kBorderColor,
                              ),
                              SizedBox(height: 24.h),

                              //  widget.sourseScreen=="home"  ?  SizedBox(height: 20.h):SizedBox(height: 100.h),
                            ],
                          ),
                        ),
            ),
            // Fixed bottom section
            if (cartItems.isNotEmpty)
              Container(
                padding: EdgeInsets.only(
                    bottom: widget.sourseScreen == "home" ? 0.h : 70.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ManropeText(
                              text: "Total",
                              fontSize: 14,
                              color: AppColor.kBlackColor,
                              fontWeight: FontWeight.w500,
                            ),
                            ManropeText(
                              text: "\$${total.toStringAsFixed(2)}",
                              fontSize: 24,
                              color: AppColor.kBlackColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        SizedBox(width: 114.w),
                        Expanded(
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: AppColor.kPrimaryColor,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25.r),
                                onTap: () {},
                                child: Center(
                                  child: ManropeText(
                                    text: AppString.checkout,
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.kBgColor,
      surfaceTintColor: AppColor.kBgColor,
      elevation: 0,
      leading: Container(
        width: 48.w,
        height: 48.h,
        margin: EdgeInsets.all(0.w),
        decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromARGB(255, 220, 222, 223), width: 1.5),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColor.kBlackColor,
              size: 20.sp,
            ),
          ),
        ),
      ),
      title: ManropeText(
        text: "Cart",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.kBlackColor,
      ),
      centerTitle: true,
      actions: [
        Container(
          width: 48.w,
          height: 48.h,
          padding: EdgeInsets.all(0.w),
          decoration: BoxDecoration(
            border: Border.all(
                color: Color.fromARGB(255, 220, 222, 223), width: 1.5),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: Icon(
              Icons.favorite_border,
              color: AppColor.kBlackColor,
              size: 24.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItemModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              color: item.imageColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: item.imageUrl.startsWith('http')
                  ? Image.network(
                      item.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(AppImage.kflashSaleImage);
                      },
                    )
                  : Image.asset(AppImage.kflashSaleImage),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                ManropeText(
                  text: item.collection,
                  fontSize: 12,
                  color: AppColor.kGrayColor,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 4.h),
                ManropeText(
                  text: item.name,
                  fontSize: 16,
                  color: AppColor.kBlackColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => _decreaseQuantity(item),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        AppColor.kGrayColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              padding: EdgeInsets.all(4.w),
                              child: Icon(
                                Icons.remove,
                                size: 20.sp,
                                color: AppColor.kGrayColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: ManropeText(
                              text: item.quantity.toString(),
                              fontSize: 14,
                              color: AppColor.kBlackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () => _increaseQuantity(item),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        AppColor.kGrayColor.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              padding: EdgeInsets.all(4.w),
                              child: Icon(
                                Icons.add,
                                size: 20.sp,
                                color: AppColor.kBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(
                  height: 40.5.h,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _toggleFavorite(item),
                      child: Icon(
                        item.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            item.isFavorite ? Colors.red : AppColor.kGrayColor,
                        size: 20.sp,
                      ),
                    ),
                    Spacer(),
                    ManropeText(
                      text: "\$${item.price.toStringAsFixed(2)}",
                      fontSize: 16,
                      color: AppColor.kBlackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingInformation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ManropeText(
            text: AppString.shippingInformation,
            fontSize: 20,
            color: AppColor.kBlackColor,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 21.h),
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                color: const Color(0xFF1D1D1D0A),
                borderRadius: BorderRadius.circular(10.r),
                border:
                    Border.all(color: const Color(0xFF1D1D1D0A), width: 1.5.w)),
            child: Row(
              children: [
                Image.asset(AppImage.kmasterCardImage),
                SizedBox(width: 12.w),
                ManropeText(
                  text: "**** **** **** 5124",
                  fontSize: 14,
                  color: AppColor.kBlackColor,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.kBlackColor,
                  size: 25.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Total (${cartItems.length} Items)",
              "\$${subtotal.toStringAsFixed(2)}"),
          SizedBox(height: 12.h),
          _buildSummaryRow(
              "Shipping Fee", "\$${shippingFee.toStringAsFixed(2)}"),
          SizedBox(height: 12.h),
          _buildSummaryRow("Taxes", "\$${taxes.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ManropeText(
          text: AppString.total,
          fontSize: 14,
          color: AppColor.kBlackColor,
          fontWeight: FontWeight.w500,
        ),
        ManropeText(
          text: value,
          fontSize: 16,
          color: AppColor.kBlackColor,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Future<void> _increaseQuantity(CartItemModel item) async {
    final success =
        await CartService.instance.updateQuantity(item.id, item.quantity + 1);
    if (success) {
      _loadCartItems();
    }
  }

  Future<void> _decreaseQuantity(CartItemModel item) async {
    if (item.quantity > 1) {
      final success =
          await CartService.instance.updateQuantity(item.id, item.quantity - 1);
      if (success) {
        _loadCartItems();
      }
    } else {
      final success = await CartService.instance.removeFromCart(item.id);
      if (success) {
        _loadCartItems();
      }
    }
  }

  Future<void> _toggleFavorite(CartItemModel item) async {
    setState(() {
      final index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
      if (index != -1) {
        cartItems[index] = item.copyWith(isFavorite: !item.isFavorite);
      }
    });
  }
}

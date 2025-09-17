import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/blocs/theme_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../../../../core/services/cart_service.dart';
import '../../../../core/models/cart_item_model.dart';
import '../../../card/presentation/screens/card_screen.dart';
import '../controller/home_bloc.dart';
import '../controller/home_event.dart';
import '../controller/home_state.dart';
import '../components/home_header.dart';
import '../components/location_section.dart';
import '../components/promotional_banner.dart';
import '../components/popular_brands_section.dart';
import '../components/flash_sale_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isSearchExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  late PageController _bannerPageController;
  int _currentBannerIndex = 0;
  late Timer _bannerTimer;
  bool _isPageLoading = true;
  bool _isBannerLoading = true;
  bool _isBrandsLoading = true;
  bool _isFlashSaleLoading = true;
  int _cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _widthAnimation = Tween<double>(
      begin: 48.0,
      end: 200.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _bannerPageController = PageController();
    _startBannerTimer();
    _simulateDataLoading();
    context.read<HomeBloc>().add(const GetCategoriesEvent());
    context.read<HomeBloc>().add(const GetProductsEvent());
    _loadCartCount();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _bannerPageController.dispose();
    _bannerTimer.cancel();
    super.dispose();
  }

  void _simulateDataLoading() {
    Timer(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _isBannerLoading = false);
    });
    Timer(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _isBrandsLoading = false);
    });
    Timer(const Duration(milliseconds: 1600), () {
      if (mounted) setState(() => _isFlashSaleLoading = false);
    });
    Timer(const Duration(milliseconds: 2000), () {
      if (mounted) setState(() => _isPageLoading = false);
    });
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentBannerIndex < 2) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }

      if (_bannerPageController.hasClients) {
        _bannerPageController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _toggleSearch() {
    setState(() => _isSearchExpanded = !_isSearchExpanded);

    if (_isSearchExpanded) {
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        _searchFocusNode.requestFocus();
      });
    } else {
      _animationController.reverse();
      _searchController.clear();
      _searchFocusNode.unfocus();
    }
  }

  Future<void> _onCartPressed() async {
    await PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: CardScreen(sourseScreen: "home"),
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
    _loadCartCount();
  }

  Future<void> _loadCartCount() async {
    try {
      final count = await CartService.instance.getCartItemCount();
      if (mounted) setState(() => _cartItemCount = count);
    } catch (e) {
      print('Error loading cart count: $e');
    }
  }

  Future<void> _addToCart(String title, String price, String imageUrl, Color bgColor, int? productId) async {
    try {
      final priceValue = double.parse(price.replaceAll('\$', ''));
      
      final cartItem = CartItemModel.fromProduct(
        id: productId ?? DateTime.now().millisecondsSinceEpoch,
        title: title,
        price: priceValue,
        imageUrl: imageUrl,
        collection: "Flash Sale Collection",
        imageColor: bgColor,
      );

      final success = await CartService.instance.addToCart(cartItem);
      
      if (success && mounted) {
        _loadCartCount();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppString.productAddedToCart.tr(namedArgs: {'productName': title})),
            backgroundColor: AppColor.kPrimaryColor,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 180,
              right: 20,
              left: 20,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppString.errorAddingToCart.tr()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 180,
              right: 20,
              left: 20,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          backgroundColor: themeState.appColor.kBgColor,
          body: SafeArea(
            child: _isPageLoading
                ? ShimmerWidgets.buildFullPageShimmer()
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 21.h),
                            HomeHeader(
                              isSearchExpanded: _isSearchExpanded,
                              widthAnimation: _widthAnimation,
                              searchController: _searchController,
                              searchFocusNode: _searchFocusNode,
                              onSearchToggle: _toggleSearch,
                              cartItemCount: _cartItemCount,
                              onCartPressed: _onCartPressed,
                            ),
                            SizedBox(height: 32.h),
                            const LocationSection(),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _isBannerLoading
                                    ? ShimmerWidgets.buildBannerShimmer()
                                    : PromotionalBanner(
                                        pageController: _bannerPageController,
                                        currentIndex: _currentBannerIndex,
                                        onPageChanged: (index) {
                                          setState(() => _currentBannerIndex = index);
                                        },
                                      ),
                                SizedBox(height: 16.5.h),
                                _isBrandsLoading
                                    ? ShimmerWidgets.buildBrandsShimmer()
                                    : BlocBuilder<HomeBloc, HomeState>(
                                        builder: (context, state) {
                                          return PopularBrandsSection(state: state);
                                        },
                                      ),
                                SizedBox(height: 17.5.h),
                                _isFlashSaleLoading
                                    ? ShimmerWidgets.buildFlashSaleShimmer()
                                    : BlocBuilder<HomeBloc, HomeState>(
                                        builder: (context, state) {
                                          return FlashSaleSection(
                                            state: state,
                                            onAddToCart: _addToCart,
                                          );
                                        },
                                      ),
                                SizedBox(height: 100.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

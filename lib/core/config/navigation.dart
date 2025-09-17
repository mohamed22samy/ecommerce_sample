import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_sample/core/utils/app_color.dart';
import 'package:ecommerce_sample/core/utils/app_font.dart';
import 'package:ecommerce_sample/core/utils/app_icon.dart';
import 'package:ecommerce_sample/core/utils/app_string.dart';
import 'package:ecommerce_sample/features/card/presentation/screens/card_screen.dart';
import 'package:ecommerce_sample/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ecommerce_sample/features/home/presentation/screens/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      Container(
        color: AppColor.kBgColor,
        child: const Center(
          child: ManropeText(
            text: AppString.searchScreen,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.kBlackColor,
          ),
        ),
      ),
       CardScreen(sourseScreen: "nav",),
      Container(
        color: AppColor.kBgColor,
        child: const Center(
          child: ManropeText(
            text: AppString.favoritesScreen,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.kBlackColor,
          ),
        ),
      ),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppIcon.kHome,
          width: 22.w,
          height: 22.h,
          color: Colors.white,
        ),
        inactiveIcon: SvgPicture.asset(
          AppIcon.kHome,
          width: 22.w,
          height: 22.h,
          color: AppColor.kGrayColor,
        ),
        title: AppString.home.tr(),
        activeColorPrimary: AppColor.kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: AppColor.kGrayColor,
        textStyle: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppIcon.kSearch,
          width: 24.w,
          height: 24.h,
          color: Colors.white,
        ),
        inactiveIcon: SvgPicture.asset(
          AppIcon.kSearch,
          width: 24.w,
          height: 24.h,
          color: AppColor.kGrayColor,
        ),
        title: AppString.search.tr(),
        activeColorPrimary: AppColor.kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: AppColor.kGrayColor,
        textStyle: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppIcon.kbag,
          width: 24.w,
          height: 24.h,
          color: Colors.white,
        ),
        inactiveIcon: SvgPicture.asset(
          AppIcon.kbag,
          width: 24.w,
          height: 24.h,
          color: AppColor.kGrayColor,
        ),
        title: AppString.compass.tr(),
        activeColorPrimary: AppColor.kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: AppColor.kGrayColor,
        textStyle: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppIcon.kHeart,
          width: 24.w,
          height: 24.h,
          color: Colors.white,
        ),
        inactiveIcon: SvgPicture.asset(
          AppIcon.kHeart,
          width: 24.w,
          height: 24.h,
          color: AppColor.kGrayColor,
        ),
        title: AppString.favorite.tr(),
        activeColorPrimary: AppColor.kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: AppColor.kGrayColor,
        textStyle: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppIcon.kUser,
          width: 24.w,
          height: 24.h,
          color: Colors.white,
        ),
        inactiveIcon: SvgPicture.asset(
          AppIcon.kUser,
          width: 24.w,
          height: 24.h,
          color: AppColor.kGrayColor,
        ),
        title: AppString.profile.tr(),
        activeColorPrimary: AppColor.kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: AppColor.kGrayColor,
        textStyle: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      key: ValueKey(context.locale.toString()),
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      padding:
          EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 35.h),
      backgroundColor: AppColor.kWhiteColor,
      isVisible: true,
      animationSettings: NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: const Duration(milliseconds: 350),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: false,
      navBarHeight: 106.h,
      navBarStyle: NavBarStyle
          .style7, 
      margin: EdgeInsets.all(0.w),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(25.r),
        colorBehindNavBar: AppColor.kBgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    );
  }
}

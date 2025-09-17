import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_sample/core/blocs/theme_bloc.dart';
import 'package:ecommerce_sample/core/services/service_locator.dart';
import 'package:ecommerce_sample/core/services/storage_service/storage_operations.dart';
import 'package:ecommerce_sample/core/utils/app_color.dart';
import 'package:ecommerce_sample/core/utils/app_font.dart';
import 'package:ecommerce_sample/core/utils/app_icon.dart';
import 'package:ecommerce_sample/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEN = context.locale.languageCode.toString() == 'en';
    
    return Scaffold(
      backgroundColor: AppColor.kBgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ManropeText(
                    text: AppString.profileTitle.tr(),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.kBlackColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    _buildProfileHeader(isEN),
                    SizedBox(height: 32.h),
                    
                    _buildSettingsSection(isEN),
                    SizedBox(height: 24.h),
                    
                   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isEN) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColor.kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIcon.kUser,
                width: 40.w,
                height: 40.h,
                color: AppColor.kPrimaryColor,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ManropeText(
                  text: AppString.userName.tr(),
                  fontSize: 18,
                  color: AppColor.kBlackColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 4.h),
                ManropeText(
                  text: AppString.userEmail,
                  fontSize: 14,
                  color: AppColor.kGrayColor,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8.h),
              
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(bool isEN) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: ManropeText(
              text: AppString.settings.tr(),
              fontSize: 16,
              color: AppColor.kBlackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: AppString.language.tr(),
            subtitle: isEN ? AppString.english.tr() : AppString.arabic.tr(),
            onTap: () => _showLanguageDialog(isEN),
          ),
          Divider(color: AppColor.kBorderColor, height: 1),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return _buildSettingItem(
                icon: themeState.isDark ? Icons.dark_mode : Icons.light_mode,
                title: AppString.theme.tr(),
                subtitle: themeState.isDark 
                    ? AppString.darkMode.tr()
                    : AppString.lightMode.tr(),
                onTap: () => _toggleTheme(),
                trailing: Switch(
                  value: themeState.isDark,
                  onChanged: (value) => _toggleTheme(),
                  activeColor: AppColor.kPrimaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: (titleColor ?? AppColor.kBlackColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: titleColor ?? AppColor.kBlackColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ManropeText(
                    text: title,
                    fontSize: 14,
                    color: titleColor ?? AppColor.kBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 2.h),
                  ManropeText(
                    text: subtitle,
                    fontSize: 12,
                    color: AppColor.kGrayColor,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.kGrayColor,
                  size: 16.sp,
                ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(bool isEN) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppString.selectLanguage.tr(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColor.kBlackColor),
              ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const ManropeText(
                  text: AppString.english,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                   color: AppColor.kBlackColor,
                ),
                onTap: () async {
                  await context.setLocale(const Locale('en', 'US'));
                  sl<StorageOperations>().write("lang_code", "en");
                  sl<StorageOperations>().write("lang_country_code", "US");
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const ManropeText(
                  text: AppString.arabic,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.kBlackColor,
                ),
                onTap: () async {
                  await context.setLocale(const Locale('ar', 'EG'));
                  sl<StorageOperations>().write("lang_code", "ar");
                  sl<StorageOperations>().write("lang_country_code", "EG");
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleTheme() {
    context.read<ThemeBloc>().add(ToggleThemeEvent());
  }
}

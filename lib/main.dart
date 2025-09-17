import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_sample/core/blocs/theme_bloc.dart';
import 'package:ecommerce_sample/core/config/app_routes.dart';
import 'package:ecommerce_sample/core/config/navigation.dart';
import 'package:ecommerce_sample/core/services/service_locator.dart';
import 'package:ecommerce_sample/core/services/storage_service/storage_operations.dart';
import 'package:ecommerce_sample/core/utils/app_theme.dart';
import 'package:ecommerce_sample/features/home/presentation/controller/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  //
  final langCode = await sl<StorageOperations>().read("lang_code");
  final countryCode = await sl<StorageOperations>().read("lang_country_code");
  //
  Locale locale = const Locale('en', "US");
  sl<StorageOperations>().write("lang_code", "$langCode");
  sl<StorageOperations>().write("lang_country_code", "$countryCode");
  if (langCode != null &&
      langCode.isNotEmpty &&
      countryCode != null &&
      countryCode.isNotEmpty) {
    locale = Locale(langCode, countryCode);
  }

  EasyLocalization.logger.enableBuildModes = [];

    runApp(EasyLocalization(
    startLocale: locale,
    path: 'assets/translations',
    supportedLocales: const [
      Locale('ar', "EG"),
      Locale('en', "US"),
    ],
    fallbackLocale: const Locale('en', "US"),
    child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => sl<ThemeBloc>(),
            lazy: false,
          ),
        
          BlocProvider<HomeBloc>(
            create: (context) => sl<HomeBloc>(),
            lazy: false,
          ),
        
        ],
        child: MyApp(
         
        )),
  ));
    configLoading();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(430, 932),
      builder: (context, child) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            key: ValueKey(context.locale.toString()),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
            builder: (context, widget) {
              return FlutterEasyLoading(
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: widget!,
                ),
              );
            },
            home: const BottomNavigation(),
            onGenerateRoute: AppRoutes.onGenerateRoutes,
          );
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
}
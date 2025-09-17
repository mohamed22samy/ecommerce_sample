import 'package:ecommerce_sample/app_root.dart';
import 'package:flutter/material.dart';
import 'navigation.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case kAppRoot:
        return _materialRoute( AppRoot(), settings);
      case kBottomNavigation:
        return _materialRoute( BottomNavigation(), settings);
      default:
        return _materialRoute( Text("text"), settings);
    }
  }

  static Route<dynamic> _materialRoute(Widget view, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => view, settings: settings);
  }
}

const String kBottomNavigation = "/bottomNavigation";

const String kAppRoot = "/";

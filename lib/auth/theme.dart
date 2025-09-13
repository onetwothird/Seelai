import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTheme {
  static const String appTitle = 'Authentication App';
  static const String fontFamily = 'SF Pro Display';
  
  static ThemeData get theme => ThemeData(
    primarySwatch: Colors.indigo,
    useMaterial3: true,
    fontFamily: fontFamily,
  );
  
  static SystemUiOverlayStyle get systemUiOverlay => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  
  static Widget wrapWithSystemUI({required Widget child}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlay,
      child: child,
    );
  }
}
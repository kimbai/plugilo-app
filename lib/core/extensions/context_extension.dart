import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  double get viewHeight => height - viewPadding.top - viewPadding.bottom;
  double get viewWidth => width - viewPadding.left - viewPadding.right;
  double get viewHeightWithoutAppBar => viewHeight - kToolbarHeight;
  double get viewHeightWithoutAppBarAndBottomNavigationBar => viewHeightWithoutAppBar - kBottomNavigationBarHeight;

  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;
  bool get isMaterial => theme.platform == TargetPlatform.android;
  bool get isCupertino => theme.platform == TargetPlatform.iOS;
  bool get isFuchsia => theme.platform == TargetPlatform.fuchsia;
  bool get isLinux => theme.platform == TargetPlatform.linux;
  bool get isMacOS => theme.platform == TargetPlatform.macOS;
  bool get isWindows => theme.platform == TargetPlatform.windows;
  bool get isMobile => isAndroid || isIOS;
  bool get isDesktop => isLinux || isMacOS || isWindows;
  bool get isAndroid => theme.platform == TargetPlatform.android;
  bool get isIOS => theme.platform == TargetPlatform.iOS;

  bool get isSmallScreen => width < 600;
  bool get isMediumScreen => width >= 600 && width < 960;
  bool get isLargeScreen => width >= 960 && width < 1280;
  bool get isExtraLargeScreen => width >= 1280;

  // void pop<T extends Object?>([T? result]) => Navigator.of(this).pop<T>(result);
  // Future<T?> push<T extends Object?>(Widget page) => Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
}

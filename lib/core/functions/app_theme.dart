import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/constance/app_colors.dart';

ThemeData appTheme({required bool isDark, required BuildContext context}) {
  
  return ThemeData(
    dialogBackgroundColor:
        isDark ? AppColors.darkScaffoldColor : AppColors.lightScaffoldColor,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark
            ? AppColors.navBarDarkModeColor
            : AppColors.navBarLightModeColor,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
    ),
    scaffoldBackgroundColor:
        isDark ? AppColors.darkScaffoldColor : AppColors.lightScaffoldColor,
    brightness: isDark ? Brightness.dark : Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor:
          isDark ? AppColors.darkScaffoldColor : AppColors.lightScaffoldColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: isDark
          ? AppColors.navBarDarkModeColor
          : AppColors.navBarLightModeColor,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor:
          isDark ? AppColors.darkScaffoldColor : AppColors.lightScaffoldColor,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:pressWave/theme/data/repositories/theme_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepoImpl extends ThemeRepo {
  @override
  Future<void> setTheme({required bool themeValue}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool('Theme_status', themeValue);
  }

  @override
  Future<void> getTheme({required BuildContext context}) async {
    await SharedPreferences.getInstance();
  }
}

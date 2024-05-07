import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/theme/data/repositories/theme_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeCubitState> {
  ThemeCubit({required this.themeRepoImpl}) : super(ThemeCubitInitial());

  final ThemeRepoImpl themeRepoImpl;
  bool themeMode = false;

  Future<void> appTheme({required bool themeValue}) async {
    await themeRepoImpl.setTheme(themeValue: themeValue);
    themeMode = themeValue;

    emit(ThemeCubitSuccess(isDark: themeValue));
  }

  Future<void> getTheme({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    themeMode = preferences.getBool('Theme_status') ?? false;
    emit(
      GetThemeCubitSuccess(),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressWave/theme/data/repositories/theme_repo_impl.dart';

part 'get_theme_state.dart';

class GetThemeCubit extends Cubit<GetThemeState> {
  GetThemeCubit({
    required this.themeRepoImpl,
  }) : super(GetThemeInitial());

  final ThemeRepoImpl themeRepoImpl;

  Future<void> getAppTheme({required BuildContext context}) async {
    await themeRepoImpl.getTheme(context: context);

    emit(
      GetThemeSuccess(),
    );
  }
}

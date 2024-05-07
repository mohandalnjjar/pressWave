part of 'theme_cubit_cubit.dart';

sealed class ThemeCubitState {}

final class ThemeCubitInitial extends ThemeCubitState {}

final class ThemeCubitSuccess extends ThemeCubitState {
  bool isDark;

  ThemeCubitSuccess({required this.isDark});
}

final class GetThemeCubitSuccess extends ThemeCubitState {
  GetThemeCubitSuccess();
}

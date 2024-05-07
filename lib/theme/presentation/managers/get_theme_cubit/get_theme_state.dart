part of 'get_theme_cubit.dart';

@immutable
sealed class GetThemeState {}

final class GetThemeInitial extends GetThemeState {}

final class GetThemeSuccess extends GetThemeState {}

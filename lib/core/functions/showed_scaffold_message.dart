import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/core/utilities/constance/app_colors.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showedScaffoldMessage(
    {required BuildContext context, required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: BlocProvider.of<ThemeCubit>(context).themeMode
                ? AppColors.navBarDarkModeColor
                : AppColors.navBarLightModeColor,
          ),
          child: Center(
            child: Text(
              message,
              style: AppStyles.styleRegular15.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}

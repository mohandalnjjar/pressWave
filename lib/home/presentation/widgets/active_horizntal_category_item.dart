import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/core/utilities/constance/app_colors.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/data/models/horizontal_list.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

class ActiveHorizntalCategoryItem extends StatelessWidget {
  const ActiveHorizntalCategoryItem({
    super.key,
    required this.horizontalCategoryModel,
  });

  final HorizontalCategoryModel horizontalCategoryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: BlocProvider.of<ThemeCubit>(context).themeMode
            ? AppColors.navBarDarkModeColor
            : AppColors.navBarLightModeColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          horizontalCategoryModel.title,
          style: AppStyles.styleRegular15(context).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:pressWave/core/utilities/constance/app_colors.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

class Gnav extends StatelessWidget {
  const Gnav({
    super.key,
    required this.currentScreen,
    this.onTabChange,
  });
  final int currentScreen;
  final void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: BlocProvider.of<ThemeCubit>(context).themeMode
                ? AppColors.secondaryDarkColor
                : AppColors.secondaryLightColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                13,
              ),
              topRight: Radius.circular(
                13,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
                selectedIndex: currentScreen,
                onTabChange: onTabChange,
                gap: 8,
                tabBackgroundColor:
                    BlocProvider.of<ThemeCubit>(context).themeMode
                        ? AppColors.navBarDarkModeColor
                        : AppColors.navBarLightModeColor.withOpacity(0.7),
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    padding: EdgeInsets.all(13),
                    icon: IconlyLight.home,
                    iconSize: 25,
                    text: 'Discover',
                  ),
                  GButton(
                    padding: EdgeInsets.all(13),
                    icon: IconlyLight.search,
                    iconSize: 25,
                    text: 'Explore',
                  ),
                  GButton(
                    icon: IconlyLight.bookmark,
                    iconSize: 25,
                    text: 'Saved',
                    padding: EdgeInsets.all(13),
                  ),
                ]),
          ),
        );
      },
    );
  }
}

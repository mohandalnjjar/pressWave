import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/presentation/widgets/drawer_item.dart';
import 'package:pressWave/home/presentation/widgets/user_Profile_header.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

class HomeViewDrawer extends StatelessWidget {
  const HomeViewDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserProfileHeader(),
          DrawerItem(
            title: "Recently Viewed",
            icon: IconlyLight.time_circle,
            onPressed: () async {
              await GoRouter.of(context).push(
                RouterConstance.kReceltyViewedViewRouter,
              );
            },
          ),
          const Divider(
            indent: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              'Press Wave Theme',
              style: AppStyles.styleSemiBold16,
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeCubitState>(
            builder: (context, state) {
              return SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      BlocProvider.of<ThemeCubit>(context).themeMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    Text(
                      BlocProvider.of<ThemeCubit>(context).themeMode
                          ? "Dark mode"
                          : "light mode",
                      style: AppStyles.styleRegular17,
                    ),
                  ],
                ),
                value: BlocProvider.of<ThemeCubit>(context).themeMode,
                onChanged: (value) async {
                  await BlocProvider.of<ThemeCubit>(context)
                      .appTheme(themeValue: value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

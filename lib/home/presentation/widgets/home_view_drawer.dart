import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserProfileHeader(),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Press Wave Theme',
              style: AppStyles.styleSemiBold19,
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeCubitState>(
            builder: (context, state) {
              return SwitchListTile(
                contentPadding: const EdgeInsets.only(right: 10),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      BlocProvider.of<ThemeCubit>(context).themeMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: BlocProvider.of<ThemeCubit>(context).themeMode
                          ? Colors.white
                          : Colors.black,
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
          const Spacer(),
          const Divider(
            indent: 40,
            endIndent: 40,
          ),
          DrawerItem(
            title: "Sign Out",
            icon: IconlyLight.logout,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: Image.asset(
                    height: 60,
                    'assets/images/errors/alert.png',
                  ),
                  title: const Text('Confirm Sign out'),
                  actionsAlignment: MainAxisAlignment.center,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              GoRouter.of(context).pushReplacement(
                                  RouterConstance.kLoginViewRouter);
                              showedScaffoldMessage(
                                  context: context,
                                  message: 'Sign out successfully');
                              await FirebaseAuth.instance.signOut();
                            },
                            child: Text(
                              'Yes, SignOut',
                              style: AppStyles.styleRegular15
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

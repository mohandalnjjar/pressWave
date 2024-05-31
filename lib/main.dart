import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/auth/data/repositories/auth_reppo_impl.dart';
import 'package:pressWave/auth/presentation/managers/login_cubit/login_cubit.dart';
import 'package:pressWave/auth/presentation/managers/signup/sign_up_cubit.dart';
import 'package:pressWave/core/functions/app_theme.dart';
import 'package:pressWave/core/utilities/app_router.dart';
import 'package:pressWave/firebase_options.dart';
import 'package:pressWave/home/data/repos/home_repos_impl.dart';
import 'package:pressWave/home/presentation/managers/update_user_image_cubit/update_user_image_cubit_cubit.dart';
import 'package:pressWave/home/presentation/managers/fetch_saved_news_cubit/fetch_saved_news_cubit.dart';
import 'package:pressWave/home/presentation/managers/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:pressWave/home/presentation/managers/get_news_cubit/news_cubit.dart';
import 'package:pressWave/home/presentation/managers/top_headlines_cubit/to_head_lines_cubit.dart';
import 'package:pressWave/theme/data/repositories/theme_repo_impl.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const PressWave(),
  );
}

class PressWave extends StatelessWidget {
  const PressWave({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateUserImageCubit(
            HomeRepoIpm(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchUserDataCubit()..fetchUserDataMethod(),
        ),
        BlocProvider(
          create: (context) => FetchSavedNewsCubit()..fetchSavedDataStream(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(
            themeRepoImpl: ThemeRepoImpl(),
          )..getTheme(context: context),
        ),
        BlocProvider(
          create: (context) => ToHeadLinesCubit(
            newsRepoIpm: HomeRepoIpm(),
          )..fetchTops(),
        ),
        BlocProvider(
          create: (context) => NewsCubit(
            newsRepoIpm: HomeRepoIpm(),
          )..fetchNews(
              category: 'all',
            ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            authRepoImpl: AuthRepoImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(
            authRepoImpl: AuthRepoImpl(),
          ),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeCubitState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Press Wave',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: appTheme(
              isDark: BlocProvider.of<ThemeCubit>(context).themeMode,
              context: context,
            ),
          );
        },
        listener: (BuildContext context, state) {},
      ),
    );
  }
}

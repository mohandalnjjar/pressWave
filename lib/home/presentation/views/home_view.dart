import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/home/data/repos/new_repos_impl.dart';
import 'package:pressWave/home/presentation/managers/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:pressWave/home/presentation/widgets/home_view_body.dart';
import 'package:pressWave/home/presentation/widgets/home_view_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchUserDataCubit(
        newsRepoIpm: NewsRepoIpm(),
      )..fetchUserDataMethod(),
      child: const Scaffold(
        endDrawer: SafeArea(
          child: HomeViewDrawer(),
        ),
        body: SafeArea(
          child: HomeViewBody(),
        ),
      ),
    );
  }
}

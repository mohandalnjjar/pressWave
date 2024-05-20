import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/home/presentation/managers/fetch_saved_news_cubit/fetch_saved_news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/empty_view_body.dart';
import 'package:pressWave/home/presentation/widgets/saved_news_list_view.dart';
import 'package:pressWave/home/presentation/widgets/saved_news_shimmer_loading_effect_list_view.dart';

class SavedViewbody extends StatelessWidget {
  const SavedViewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSavedNewsCubit, FetchSavedNewsState>(
      builder: (context, state) {
        if (state is FetchSavedNewsLoading) {
          return const SavedNewShimmerLoadingEffectListView();
        } else if (state is FetchSavedNewsSuccessful) {
          if (state.data.get('UserSavedNews').isNotEmpty) {
            return SavedNewsListView(
              state: state,
            );
          } else {
            return const EmptyViewBody(
              image: AppAssets.emptyNews,
              title: 'There is no saved news now',
              subTitle: 'Discover News all over the world',
              buttonTitle: 'Discover Now !?',
            );
          }
        } else if (state is FetchSavedNewsFailure) {
          return Text(state.message);
        } else {
          return const Text('Some thing went wrong,please try again');
        }
      },
    );
  }
}

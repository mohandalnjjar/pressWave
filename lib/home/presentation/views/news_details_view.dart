import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/core/functions/check_itmes_in_list.dart';
import 'package:pressWave/core/utilities/services/reomve_itme_from_firenase.dart';
import 'package:pressWave/core/utilities/services/save_news_to_fire_store.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/managers/fetch_saved_news_cubit/fetch_saved_news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/news_details_view_body.dart';

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({
    super.key,
    required this.newsModel,
  });
  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSavedNewsCubit, FetchSavedNewsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:  Text(
              'Details',
              style: AppStyles.styleSemiBold27(context),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  checkListItmes(
                    list: state is FetchSavedNewsSuccessful
                        ? state.data.get('UserSavedNews')
                        : [],
                    newsModel: newsModel,
                  )
                      ? await reomveItmeFromFirebase(newsModel)
                      : await saveNewOnfireStore(
                          newsModel: newsModel,
                        );
                },
                icon: Icon(
                  checkListItmes(
                    list: state is FetchSavedNewsSuccessful
                        ? state.data.get('UserSavedNews')
                        : [],
                    newsModel: newsModel,
                  )
                      ? Icons.delete
                      : Icons.bookmark,
                ),
              ),
            ],
          ),
          body: NewsDetailsViewBody(
            newsModel: newsModel,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/managers/fetch_saved_news_cubit/fetch_saved_news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/second_news_item_desgin.dart';

class SavedViewbody extends StatelessWidget {
  const SavedViewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSavedNewsCubit, FetchSavedNewsState>(
      builder: (context, state) {
        if (state is FetchSavedNewsLoading) {
          return const Text('laoidng');
        } else if (state is FetchSavedNewsSuccessful) {
          return ListView.builder(
            itemCount: state.data.get('UserSavedNews').length,
            itemBuilder: ((context, index) => SecondNewsItemDesgin(
                  newsModel: NewsModel(
                    author: state.data.get('UserSavedNews')[index]['author'],
                    title: state.data.get('UserSavedNews')[index]['title'],
                    description: state.data.get('UserSavedNews')[index]
                        ['description'],
                    url: state.data.get('UserSavedNews')[index]['url'],
                    urlToImage: state.data.get('UserSavedNews')[index]
                        ['urlToImage'],
                    publishedAt: DateTime.now(),
                    content: state.data.get('UserSavedNews')[index]['content'],
                  ),
                )),
          );
        } else {
          return const Text('error');
        }
      },
    );
  }
}


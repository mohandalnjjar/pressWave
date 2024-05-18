import 'package:flutter/material.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/managers/fetch_saved_news_cubit/fetch_saved_news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/second_news_item_desgin.dart';

class SavedNewsListView extends StatelessWidget {
  const SavedNewsListView({
    super.key,
    required this.state,
  });
  final FetchSavedNewsSuccessful state;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.data.get('UserSavedNews').length,
      itemBuilder: ((context, index) => SecondNewsItemDesgin(
            newsModel: NewsModel(
              author: state.data.get('UserSavedNews')[index]['author'],
              title: state.data.get('UserSavedNews')[index]['title'],
              description: state.data.get('UserSavedNews')[index]
                  ['description'],
              url: state.data.get('UserSavedNews')[index]['url'],
              urlToImage: state.data.get('UserSavedNews')[index]['urlToImage'],
              publishedAt: DateTime.now(),
              content: state.data.get('UserSavedNews')[index]['content'],
            ),
          )),
    );
  }
}

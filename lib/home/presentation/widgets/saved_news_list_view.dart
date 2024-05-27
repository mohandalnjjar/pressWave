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
      itemCount: state.savedData.length,
      itemBuilder: ((context, index) => SecondNewsItemDesgin(
            newsModel: NewsModel(
              author: state.savedData[index].author,
              title: state.savedData[index].title,
              description: state.savedData[index].description,
              url: state.savedData[index].url,
              urlToImage: state.savedData[index].url,
              publishedAt: state.savedData[index].publishedAt,
              content: state.savedData[index].content,
            ),
          )),
    );
  }
}

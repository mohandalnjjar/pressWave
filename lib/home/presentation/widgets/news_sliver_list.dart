import 'package:flutter/material.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/widgets/news_item.dart';

class NewsSliverList extends StatelessWidget {
  const NewsSliverList({
    super.key,
    required this.newsModelList,
  });
  final List<NewsModel> newsModelList;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: newsModelList.length,
      itemBuilder: (context, index) {
        return NewsItem(
          newsModel: newsModelList[index],
        );
      },
    );
  }
}

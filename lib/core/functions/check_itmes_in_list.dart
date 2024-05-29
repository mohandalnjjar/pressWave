import 'package:pressWave/home/data/models/news_model.dart';

bool checkListItmes(
    {required List<dynamic> list, required NewsModel newsModel}) {
  for (var newsItme in list) {
    if (newsItme['title'].contains(newsModel.title)) {
      return true;
    }
  }

  return false;
}


import 'package:flutter/material.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/managers/fetch_saved_news_cubit/fetch_saved_news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/second_news_item_desgin.dart';

class SavedNewsListView extends StatefulWidget {
  const SavedNewsListView({
    super.key,
    required this.state,
  });
  final FetchSavedNewsSuccessful state;

  @override
  State<SavedNewsListView> createState() => _SavedNewsListViewState();
}

class _SavedNewsListViewState extends State<SavedNewsListView> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    // Animate to the end of the list when the list is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: widget.state.data.get('UserSavedNews').length,
      itemBuilder: ((context, index) => SecondNewsItemDesgin(
            newsModel: NewsModel(
              author: widget.state.data.get('UserSavedNews')[index]['author'],
              title: widget.state.data.get('UserSavedNews')[index]['title'],
              description: widget.state.data.get('UserSavedNews')[index]
                  ['description'],
              url: widget.state.data.get('UserSavedNews')[index]['url'],
              urlToImage: widget.state.data.get('UserSavedNews')[index]
                  ['urlToImage'],
              // publishedAt: DateTime.now(),
              content: widget.state.data.get('UserSavedNews')[index]['content'],
            ),
          )),
    );
  }
}

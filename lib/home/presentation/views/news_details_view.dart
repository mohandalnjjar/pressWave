import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/utilities/services/save_news_to_fire_store.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/widgets/news_details_view_body.dart';

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({super.key, required this.newsModel});
  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: AppStyles.styleSemiBold27,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await saveNewOnfireStore(
                    newsModel: newsModel, context: context);
              } catch (e) {
                showedScaffoldMessage(
                  context: context,
                  message: e.toString(),
                );
              }
            },
            icon: const Icon(
              IconlyLight.bookmark,
            ),
          ),
        ],
      ),
      body: NewsDetailsViewBody(
        newsModel: newsModel,
      ),
    );
  }
}

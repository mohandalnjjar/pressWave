import 'package:flutter/material.dart';
import 'package:pressWave/home/presentation/widgets/Saved_news_loading_shimmer_effect.dart';

class SavedNewShimmerLoadingEffectListView extends StatelessWidget {
  const SavedNewShimmerLoadingEffectListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: SavedNewShimmerLoadingEffect(),
          );
        });
  }
}

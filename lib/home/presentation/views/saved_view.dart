import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/presentation/widgets/saved_view)body.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved",
          style: AppStyles.styleSemiBold27,
        ),
      ),
      body: const SafeArea(
        child: SavedViewbody(),
      ),
    );
  }
}

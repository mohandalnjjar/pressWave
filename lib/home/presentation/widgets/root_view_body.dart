import 'package:flutter/material.dart';
import 'package:pressWave/home/presentation/views/home_view.dart';
import 'package:pressWave/home/presentation/views/saved_view.dart';
import 'package:pressWave/home/presentation/views/search_view.dart';

class RootViewBody extends StatelessWidget {
  const RootViewBody({
    super.key,
    required this.controller,
    this.onPageChanged,
  });
  final PageController controller;
  final void Function(int)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: const [
        HomeView(),
        SearchView(),
        SavedView(),
      ],
    );
  }
}

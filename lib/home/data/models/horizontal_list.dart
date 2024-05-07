import 'package:flutter/material.dart';

class HorizontalCategoryModel {
  final String title;
  final void Function(BuildContext context) onPresses;

  const HorizontalCategoryModel({required this.title, required this.onPresses});
}

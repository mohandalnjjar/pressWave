import 'package:flutter/material.dart';
import 'package:pressWave/home/data/models/horizontal_list.dart';
import 'package:pressWave/home/presentation/widgets/In_active_horizntal_category_item.dart';
import 'package:pressWave/home/presentation/widgets/active_horizntal_category_item.dart';

class HorizonalCategoryItem extends StatelessWidget {
  const HorizonalCategoryItem({
    super.key,
    required this.horizontalCategoryModel,
    required this.isActive,
  });

  final HorizontalCategoryModel horizontalCategoryModel;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveHorizntalCategoryItem(
            horizontalCategoryModel: horizontalCategoryModel,
          )
        : InActiveHorizntalCategoryItem(
            horizontalCategoryModel: horizontalCategoryModel);
  }
}

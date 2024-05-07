import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/home/data/models/horizontal_list.dart';
import 'package:pressWave/home/presentation/managers/get_news_cubit/news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/horizonal_category_item.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

class HorizontalCategoryList extends StatefulWidget {
  const HorizontalCategoryList({
    super.key,
  });

  @override
  State<HorizontalCategoryList> createState() => _HorizontalCategoryListState();
}

class _HorizontalCategoryListState extends State<HorizontalCategoryList> {
  int selectedIndex = 0;
  final List<HorizontalCategoryModel> items = [
    HorizontalCategoryModel(
      title: 'All',
      onPresses: (BuildContext context) async {
        await BlocProvider.of<NewsCubit>(context).fetchNews(category: 'All');
      },
    ),
    HorizontalCategoryModel(
      title: 'Technology',
      onPresses: (BuildContext context) async {
        await BlocProvider.of<NewsCubit>(context)
            .fetchNews(category: 'Technology');
      },
    ),
    HorizontalCategoryModel(
      title: 'Sports',
      onPresses: (BuildContext context) async {
        await BlocProvider.of<NewsCubit>(context).fetchNews(category: 'Sports');
      },
    ),
    HorizontalCategoryModel(
      title: 'Education',
      onPresses: (BuildContext context) async {
        await BlocProvider.of<NewsCubit>(context)
            .fetchNews(category: 'Education');
      },
    ),
    HorizontalCategoryModel(
      title: 'politics',
      onPresses: (BuildContext context) async {
        await BlocProvider.of<NewsCubit>(context)
            .fetchNews(category: 'politics');
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                if (selectedIndex != index) {
                  items[index].onPresses(context);
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: HorizonalCategoryItem(
                horizontalCategoryModel: items[index],
                isActive: selectedIndex == index ? true : false,
              ),
            ),
          ),
        );
      },
    );
  }
}

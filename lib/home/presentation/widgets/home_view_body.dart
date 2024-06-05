import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/custom_app_bar.dart';
import 'package:pressWave/core/widgets/news_shimmer_loading_effect.dart';
import 'package:pressWave/home/presentation/managers/get_news_cubit/news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/horizontal_category_list.dart';
import 'package:pressWave/home/presentation/widgets/news_sliver_list.dart';
import 'package:pressWave/home/presentation/widgets/top_head_Lines_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppbar(
            title: 'Discover',
            onpressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
            child: Row(
              children: [
                Text(
                  'Top Head Lines',
                  style: AppStyles.styleSemiBold24(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Ionicons.newspaper,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: TopHeadLinesWidget(),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: HorizontalCategoryList(),
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                  top: 10,
                ),
                child: Text(
                  'News',
                  style: AppStyles.styleSemiBold24(context),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                FontAwesomeIcons.newspaper,
              )
            ],
          ),
        ),
        BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NewsSuccess) {
              return NewsSliverList(newsModelList: state.newsList);
            } else if (state is NewsLoading) {
              return SliverList.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: NewShimmerLoadingEffect(),
                ),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('under constructions'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

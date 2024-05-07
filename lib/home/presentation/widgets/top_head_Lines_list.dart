import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressWave/home/presentation/managers/top_headlines_cubit/to_head_lines_cubit.dart';
import 'package:pressWave/home/presentation/widgets/top_head_lines_item.dart';
import 'package:pressWave/home/presentation/widgets/top_lines_shimmer.dart';

class TopHeadLinesWidget extends StatelessWidget {
  const TopHeadLinesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToHeadLinesCubit, TopHeadLinesState>(
      builder: (context, state) {
        if (state is TopHeadLinesLoading) {
          return const TopHeadLinesShimmer();
        } else if (state is TopHeadLinesSuccess) {
          return CarouselSlider.builder(
            itemCount: state.newsList.length,
            options: CarouselOptions(
              height: MediaQuery.sizeOf(context).height * .26,
              viewportFraction: .93,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    TopHeadLines(
              newsModel: state.newsList[itemIndex],
            ),
          );
        } else if (state is TopHeadLinesFailure) {
          return Text(state.errorMessage);
        } else {
          return const Text('errrorr');
        }
      },
    );
  }
}

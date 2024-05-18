import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressWave/core/widgets/news_shimmer_loading_effect.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/managers/get_news_cubit/news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/custom_text_form_field.dart';
import 'package:pressWave/home/presentation/widgets/news_sliver_list.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({
    super.key,
  });

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody>
    with AutomaticKeepAliveClientMixin<SearchViewBody> {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<NewsCubit>(context).fetchNews(category: 'all');
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<NewsModel> result = [];

  List<NewsModel> resultOnSearch = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomTextFromField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  resultOnSearch = result
                      .where((element) =>
                          element.title.toLowerCase().contains(value))
                      .toList();
                });
              },
              hint: 'Search Now !?',
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                    });
                  },
                  icon: const Icon(
                    FontAwesomeIcons.xmark,
                    color: Colors.grey,
                  )),
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 10,
          )),
          BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {
              if (state is NewsSuccess) {
                result = state.newsList;
              }
            },
            builder: (context, state) {
              if (state is NewsSuccess) {
                if (_controller.text.isNotEmpty) {
                  return NewsSliverList(
                    newsModelList: resultOnSearch,
                  );
                } else {
                  return NewsSliverList(
                    newsModelList: result,
                  );
                }
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
      ),
    );
  }
}

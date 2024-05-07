import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/presentation/widgets/search_vewi_body.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Explore",
            style: AppStyles.styleSemiBold27,
          ),
        ),
        body: const SafeArea(
          child: SearchViewBody(),
        ),
      ),
    );
  }
}

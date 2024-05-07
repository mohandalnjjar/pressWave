import 'package:flutter/material.dart';
import 'package:pressWave/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:pressWave/home/presentation/widgets/root_view_body.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late PageController controller;
  int currentScreen = 0;
  @override
  void initState() {
    controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RootViewBody(
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              currentScreen = value;
            });
          },
        ),
      ),
      bottomNavigationBar: Gnav(
        currentScreen: currentScreen,
        onTabChange: (value) {
          setState(() {
            currentScreen = value;
            controller.jumpToPage(currentScreen);
          });
        },
      ),
    );
  }
}

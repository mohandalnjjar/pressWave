import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/presentation/widgets/recently_viewed_view_body.dart';

class ReceltyViewedView extends StatelessWidget {
  const ReceltyViewedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recntly Viewed',
          style: AppStyles.styleSemiBold27,
        ),
      ),
      body: SafeArea(
        child: ReceltyViewedViewBody(),
      ),
    );
  }
}

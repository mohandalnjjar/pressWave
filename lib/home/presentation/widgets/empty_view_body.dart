import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/styles.dart';

class EmptyViewBody extends StatelessWidget {
  const EmptyViewBody({
    super.key,
    required this.title,
    required this.subTitle,
    required this.buttonTitle,
    required this.image,
  });
  final String image;

  final String title;
  final String subTitle;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .30,
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: Image.asset(fit: BoxFit.contain, image),
            ),
          ),
        ),
        Text(
          title,
          style: AppStyles.styleSemiBold24(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subTitle,
          style: AppStyles.styleRegular17(context),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context)
                .pushReplacement(RouterConstance.kRootViewRouter);
          },
          child: Text(buttonTitle),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

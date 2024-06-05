import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/styles.dart';

class AuthorsItem extends StatelessWidget {
  const AuthorsItem({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppAssets.unKnownUser,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
         Text(
          'BBC',
          style: AppStyles.styleRegular14(context),
          maxLines: 2,
        ),
      ],
    );
  }
}

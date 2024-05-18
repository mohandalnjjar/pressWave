import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewShimmerLoadingEffect extends StatelessWidget {
  const NewShimmerLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey,
      child: Row(
        children: [
          Container(
            height: 125,
            width: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ThemeData().dialogBackgroundColor.withOpacity(0.3),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 23,
                width: MediaQuery.sizeOf(context).width * .5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: ThemeData().dialogBackgroundColor.withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 23,
                width: MediaQuery.sizeOf(context).width * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: ThemeData().dialogBackgroundColor.withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 23,
                width: MediaQuery.sizeOf(context).width * .6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: ThemeData().dialogBackgroundColor.withOpacity(0.3),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

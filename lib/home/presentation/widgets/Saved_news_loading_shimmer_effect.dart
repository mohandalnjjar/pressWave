import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SavedNewShimmerLoadingEffect extends StatelessWidget {
  const SavedNewShimmerLoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey,
      child: Expanded(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ThemeData().dialogBackgroundColor.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color:
                            ThemeData().dialogBackgroundColor.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 23,
                      width: MediaQuery.sizeOf(context).width * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color:
                            ThemeData().dialogBackgroundColor.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

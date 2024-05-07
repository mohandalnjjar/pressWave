import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/home/data/models/news_model.dart';

class SecondNewsItemDesgin extends StatelessWidget {
  const SecondNewsItemDesgin({
    super.key,
    required this.newsModel,
  });
  final NewsModel newsModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await GoRouter.of(context)
            .push(RouterConstance.kNewsDetailsViewRouter, extra: newsModel);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.sizeOf(context).height * .37,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                height: MediaQuery.sizeOf(context).height * .25,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: newsModel.urlToImage ??
                    'https://images.pexels.com/photos/99435/pexels-photo-99435.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                placeholder: (context, error) => const ShimmerEffect(),
                errorWidget: (context, url, error) => Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/errors/error404_not_found.jpg',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                newsModel.title,
                style: AppStyles.styleRegular17,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  newsModel.author!,
                  style: AppStyles.styleRegular15,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(
                  'assets/images/verify.png',
                  height: 23,
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

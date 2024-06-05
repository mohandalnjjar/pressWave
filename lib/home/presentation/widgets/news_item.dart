import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/home/data/models/news_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    super.key,
    required this.newsModel,
  });
  final NewsModel newsModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await GoRouter.of(context).push(
          RouterConstance.kNewsDetailsViewRouter,
          extra: NewsModel(
            author: newsModel.author,
            title: newsModel.title,
            description: newsModel.description,
            url: newsModel.url,
            urlToImage: newsModel.urlToImage,
            // publishedAt: newsModel.publishedAt,
            content: newsModel.content,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        height: MediaQuery.of(context).size.height * .17,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 2.3 / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: newsModel.urlToImage ??
                      'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?t=st=1714342695~exp=1714346295~hmac=4a2d45e18d551b057a799b41887a663dec03ed4a5cc40b4afa6da71f46ba7643&w=740',
                  placeholder: (context, error) => const ShimmerEffect(),
                  errorWidget: (context, url, error) => Image.asset(
                    fit: BoxFit.cover,
                    'assets/images/errors/error404_not_found.jpg',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsModel.title,
                    style: AppStyles.styleSemiBold18(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .2,
                        child: Text(
                          newsModel.author ?? 'Unknown Author',
                          style: AppStyles.styleSemiBold17(context),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (newsModel.author != null)
                        Image.asset(
                          'assets/images/verify.png',
                          height: 23,
                        ),
                      const Spacer(),
                       Text(
                        '',
                        style: AppStyles.styleRegular14(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

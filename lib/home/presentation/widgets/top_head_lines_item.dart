import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/data/models/news_model.dart';

class TopHeadLines extends StatelessWidget {
  const TopHeadLines({
    super.key,
    required this.newsModel,
  });

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: GestureDetector(
        onTap: () async {
          await GoRouter.of(context).push(
            RouterConstance.kNewsDetailsViewRouter,
            extra: newsModel,
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                newsModel.urlToImage ??
                    'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?t=st=1714504436~exp=1714508036~hmac=631a6d2845ab8e6dba0de2911ad1446075fc5f30623b7ded20f05d9ced7231ea&w=740',
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.5),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsModel.title,
                    style:
                        AppStyles.styleSemiBold21(context).copyWith(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    newsModel.author ?? 'Unknown Author',
                    style: AppStyles.styleRegular18(context).copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    '',
                    style:
                        AppStyles.styleRegular16(context).copyWith(color: Colors.white),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

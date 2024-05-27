import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsViewBody extends StatelessWidget {
  const NewsDetailsViewBody({
    super.key,
    required this.newsModel,
  });
  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    newsModel.title,
                    style: AppStyles.styleSemiBold24,
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Author : ${newsModel.author ?? 'Unknown Author'}',
                          style: AppStyles.styleSemiBold17,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (newsModel.author != null)
                        Image.asset(
                          'assets/images/verify.png',
                          height: 23,
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  AspectRatio(
                    aspectRatio: 2 / 1.5,
                    child: ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: newsModel.urlToImage ??
                            'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?t=st=1714342695~exp=1714346295~hmac=4a2d45e18d551b057a799b41887a663dec03ed4a5cc40b4afa6da71f46ba7643&w=740',
                        placeholder: (context, url) => const ShimmerEffect(),
                        errorWidget: (context, url, error) => Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/errors/error404_not_found.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'published at :${newsModel.publishedAt.toDate().year}-${newsModel.publishedAt.toDate().month}-${newsModel.publishedAt.toDate().day}',
                    style:
                        AppStyles.styleRegular18.copyWith(color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Description',
                    style: AppStyles.styleSemiBold24,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    newsModel.description ??
                        'Sorry there is no description for this articles',
                    style: AppStyles.styleRegular18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Content',
                    style: AppStyles.styleSemiBold24,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    newsModel.content ??
                        'Sorry there is no content for this articles',
                    style: AppStyles.styleRegular18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Reference',
                    style: AppStyles.styleSemiBold24,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Uri _url = Uri.parse(newsModel.url!);
                      if (!await canLaunchUrl(_url)) {
                        await launchUrl(_url);
                      }
                    },
                    child: Text(
                      newsModel.url ??
                          'Sorry currently there is no reference for this articles',
                      style: AppStyles.styleRegular18.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

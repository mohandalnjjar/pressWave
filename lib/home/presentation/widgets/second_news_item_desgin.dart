import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/services/reomve_itme_from_firenase.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  height: MediaQuery.sizeOf(context).height * .25,
                  width: double.infinity,
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
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text(
                  newsModel.title,
                  style: AppStyles.styleRegular17,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      newsModel.author ?? 'Unknown Author',
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
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        await reomveItmeFromFirebase( newsModel);
                      },
                      icon: const Icon(Icons.checklist),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

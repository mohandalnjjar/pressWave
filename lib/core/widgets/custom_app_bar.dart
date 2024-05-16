import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.onpressed,
    this.iconSize = 24,
  });

  final String title;
  final double iconSize;

  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final User? user = firebaseAuth.currentUser;

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyles.styleSemiBold27,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            onPressed: onpressed,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: snapshot.data!.get('userImage'),
                            placeholder: (context, url) {
                              return const AspectRatio(
                                aspectRatio: 1,
                                child: ShimmerEffect(),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAssets.unKnownUser);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Text('Waiting');
                } else if (snapshot.hasError) {
                  return const Text('error');
                } else {
                  return Text(snapshot.data.toString());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

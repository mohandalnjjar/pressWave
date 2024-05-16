import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/constance/app_colors.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/home/presentation/widgets/edit_profile_image_widget.dart';
import 'package:pressWave/theme/presentation/managers/theme_cubit/theme_cubit_cubit.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.26,
          decoration: BoxDecoration(
            color: BlocProvider.of<ThemeCubit>(context).themeMode
                ? const Color(0xff22222E)
                : const Color(0xffCDE8E5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(
                          15,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text(''),
                          ),
                        );
                      },
                      icon: const Icon(
                        Ionicons.information_circle_outline,
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(
                          15,
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        IconlyLight.edit,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 130,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            snapshot.data!.get('userImage'),
                                        placeholder: (context, url) {
                                          return const AspectRatio(
                                            aspectRatio: 1,
                                            child: ShimmerEffect(),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                              AppAssets.unKnownUser);
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
                              return Text(
                                snapshot.data.toString(),
                              );
                            }
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 55,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const EditProfileImageWidget(),
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: BlocProvider.of<ThemeCubit>(context)
                                        .themeMode
                                    ? AppColors.navBarDarkModeColor
                                    : AppColors.navBarLightModeColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.data!.get('UserName'),
                                style: AppStyles.styleSemiBold19,
                              ),
                              Text(
                                snapshot.data!.get('Email'),
                                style: AppStyles.styleRegular15
                                    .copyWith(color: Colors.grey),
                              ),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Waiting');
                        } else if (snapshot.hasError) {
                          return const Text('error');
                        } else {
                          return Text(
                            snapshot.data.toString(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
import 'package:pressWave/home/presentation/managers/update_user_image_cubit/update_user_image_cubit_cubit.dart';
import 'package:pressWave/home/presentation/managers/fetch_user_data_cubit/fetch_user_data_cubit.dart';
import 'package:pressWave/home/presentation/widgets/icon_with_undeline_text.dart';

class EditProfileImageWidget extends StatefulWidget {
  const EditProfileImageWidget({
    super.key,
  });

  @override
  State<EditProfileImageWidget> createState() => _EditProfileImageWidgetState();
}

class _EditProfileImageWidgetState extends State<EditProfileImageWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    User? user = firebaseAuth.currentUser;

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<FetchUserDataCubit, FetchUserDataState>(
                builder: (context, state) {
                  if (state is FetchUserDataSuccessful) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: state.data.get('userImage'),
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
                  } else {
                    return const SizedBox(
                      height: 42,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipOval(
                          child: ShimmerEffect(),
                        ),
                      ),
                    );
                  }
                },
              ),
               Text(
                'Change profile image',
                style: AppStyles.styleSemiBold18(context),
              ),
            ],   
          ),
          const SizedBox(
            height: 17,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconWithUnderlineText(
                iconData: IconlyLight.folder,
                title: 'Studio',
                onTap: () async {
                  await BlocProvider.of<UpdateUserImageCubit>(context)
                      .updateImageMethod(
                          context: context, imageSource: ImageSource.gallery);
                },
              ),
              IconWithUnderlineText(
                iconData: IconlyLight.camera,
                title: 'Camera',
                onTap: () async {
                  await BlocProvider.of<UpdateUserImageCubit>(context)
                      .updateImageMethod(
                          context: context, imageSource: ImageSource.camera);
                },
              ),
              IconWithUnderlineText(
                iconData: IconlyLight.delete,
                title: 'Remove',
                onTap: () async {
                  context.pop();

                  showedScaffoldMessage(
                      context: context, message: 'there is no image ');

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .update(
                    {
                      'userImage': '',
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

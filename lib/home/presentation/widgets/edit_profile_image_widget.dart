import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pressWave/core/utilities/app_assets.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/shimmer_effect.dart';
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
    final ref = FirebaseStorage.instance.ref().child('UserImages').child(
          '${user!.email}.profileImage',
        );
    ImagePicker picker = ImagePicker();
    XFile? file;
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
                        height: 60,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipOval(
                            child: ModalProgressHUD(
                              inAsyncCall: isLoading,
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
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 130,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ShimmerEffect(),
                      ),
                    );
                  }
                },
              ),
              const Text(
                'Change profile image',
                style: AppStyles.styleSemiBold18,
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
                  XFile? file =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    isLoading = true;
                  });

                  await ref.putFile(File(file!.path));

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .update(
                    {
                      'userImage': await ref.getDownloadURL(),
                    },
                  );
                  setState(() {
                    isLoading = false;
                    context.pop();
                  });
                },
              ),
              IconWithUnderlineText(
                iconData: IconlyLight.camera,
                title: 'Camera',
                onTap: () async {
                  file = await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    isLoading = true;
                  });
                  await ref.putFile(File(file!.path));

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .update(
                    {
                      'userImage': await ref.getDownloadURL(),
                    },
                  );
                  setState(() {
                    isLoading = false;
                    context.pop();
                  });
                },
              ),
              IconWithUnderlineText(
                iconData: IconlyLight.delete,
                title: 'Remove',
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .update(
                    {
                      'userImage': '',
                    },
                  );
                  setState(() {
                    isLoading = false;
                    context.pop();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

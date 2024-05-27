import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/presentation/managers/fetch_saved_news_cubit/fetch_saved_news_cubit.dart';
import 'package:pressWave/home/presentation/widgets/saved_viewbody.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView>
    with AutomaticKeepAliveClientMixin<SavedView> {
  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved news",
          style: AppStyles.styleSemiBold27,
        ),
        actions: [
          BlocBuilder<FetchSavedNewsCubit, FetchSavedNewsState>(
            builder: (context, state) {
              if (state is FetchSavedNewsSuccessful) {
                if (state.savedData.isNotEmpty) {
                  return IconButton(
                    onPressed: () async {
                      final auth = FirebaseAuth.instance;
                      User? user = auth.currentUser;
                      final userDb = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid);

                      try {
                        await userDb.update(
                          {
                            'UserSavedNews': [],
                          },
                        );
                      } catch (e) {
                        showedScaffoldMessage(
                            context: context, message: e.toString());
                      }
                    },
                    icon: const Icon(
                      IconlyLight.delete,
                    ),
                  );
                } else {
                  return const Icon(
                    Icons.search,
                    color: Colors.transparent,
                  );
                }
              } else {
                return const Icon(
                  Icons.search,
                  color: Colors.transparent,
                );
              }
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: SavedViewbody(),
      ),
    );
  }
}

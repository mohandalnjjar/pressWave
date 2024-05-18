import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/utilities/styles.dart';
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
          "Saved",
          style: AppStyles.styleSemiBold27,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final auth = FirebaseAuth.instance;
              User? user = auth.currentUser;
              final userDb =
                  FirebaseFirestore.instance.collection('users').doc(user!.uid);

              try {
                await userDb.update(
                  {
                    'UserSavedNews': [],
                  },
                );
              } catch (e) {
                showedScaffoldMessage(context: context, message: e.toString());
              }
            },
            icon: const Icon(
              Icons.checklist_sharp,
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: SavedViewbody(),
      ),
    );
  }
}

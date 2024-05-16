import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SavedViewbody extends StatelessWidget {
  const SavedViewbody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              Text(
                '${snapshot.data!.get('UserSavedNews')}',
              ),
            ],
          );
        } else {
          return const Text('error');
        }
      },
    );
  }
}

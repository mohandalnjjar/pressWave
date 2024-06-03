import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> changeUsrName({required String newName}) async {
  final auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final userDb = FirebaseFirestore.instance.collection('users').doc(user!.uid);

  try {
    await userDb.update(
      {
        'UserName': newName,
      },
    );
  } catch (e) {}
}

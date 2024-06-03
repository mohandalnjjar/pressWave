import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pressWave/home/data/models/news_model.dart';

Future<void> reomveItmeFromFirebase(NewsModel newsModel) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  final userDb = FirebaseFirestore.instance.collection('users').doc(user!.uid);
  await userDb.update({
    'UserSavedNews': FieldValue.arrayRemove([
      {
        'author': newsModel.author,
        'title': newsModel.title,
        'description': newsModel.description,
        'url': newsModel.url,
        'urlToImage': newsModel.urlToImage,
        'content': newsModel.content,
      }
      
    ]),
  });
}

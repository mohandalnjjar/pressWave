import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/presentation/widgets/second_news_item_desgin.dart';

class SavedViewbody extends StatefulWidget {
  const SavedViewbody({
    super.key,
  });

  @override
  State<SavedViewbody> createState() => _SavedViewbodyState();
}

class _SavedViewbodyState extends State<SavedViewbody> {
  final _scrollControler = ScrollController();
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final userDb =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    return StreamBuilder(
      stream: userDb.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            controller: _scrollControler,
            itemCount: snapshot.data!.get('UserSavedNews').length,
            itemBuilder: (context, index) {
              return SecondNewsItemDesgin(
                newsModel: NewsModel(
                  author: snapshot.data!.get('UserSavedNews')[index]['author'],
                  title: snapshot.data!.get('UserSavedNews')[index]['title'],
                  description: snapshot.data!.get('UserSavedNews')[index]
                      ['description'],
                  url: snapshot.data!.get('UserSavedNews')[index]['url'],
                  urlToImage: snapshot.data!.get('UserSavedNews')[index]
                      ['urlToImage'],
                  publishedAt: DateTime.now(),
                  content: snapshot.data!.get('UserSavedNews')[index]
                      ['content'],
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('waiting'),
          );
        } else if (snapshot.hasError) {
          return const Text('error');
        } else if (snapshot.data?.get('UserSavedNews').isEmpty ?? true) {
          return const Center(
            child: Text('there is no saved items'),
          );
        } else {
          return const Center(child: Text('I Can fix any problem'));
        }
      },
    );
  }
}

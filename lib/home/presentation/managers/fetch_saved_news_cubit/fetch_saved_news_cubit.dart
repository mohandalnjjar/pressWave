import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pressWave/home/data/models/news_model.dart';

part 'fetch_saved_news_state.dart';

class FetchSavedNewsCubit extends Cubit<FetchSavedNewsState> {
  FetchSavedNewsCubit() : super(FetchSavedNewsInitial());

  void fetchDataStream() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    emit(
      FetchSavedNewsLoading(),
    );

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      List<NewsModel> savedData = [];

      for (var item in documentSnapshot.get('UserSavedNews')) {
        savedData.add(
          NewsModel.fromFireBase(item),
        );
      }

      emit(
        FetchSavedNewsSuccessful(savedData: savedData),
      );
    } catch (e) {
      emit(
        FetchSavedNewsFailure(
          message: e.toString(),
        ),
      );
    }
  }
}

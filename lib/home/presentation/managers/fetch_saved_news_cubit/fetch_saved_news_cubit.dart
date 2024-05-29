import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'fetch_saved_news_state.dart';

class FetchSavedNewsCubit extends Cubit<FetchSavedNewsState> {
  FetchSavedNewsCubit() : super(FetchSavedNewsInitial());

  void fetchDataStream() {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    emit(
      FetchSavedNewsLoading(),
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((data) {
      emit(
        FetchSavedNewsSuccessful(data: data),
      );
    }, onError: (error) {
      emit(
        FetchSavedNewsFailure(
          message: error.toString(),
        ),
      );
    });
  }
}

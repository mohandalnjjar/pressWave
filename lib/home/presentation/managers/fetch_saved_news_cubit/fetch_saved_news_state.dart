part of 'fetch_saved_news_cubit.dart';

@immutable
sealed class FetchSavedNewsState {}

final class FetchSavedNewsInitial extends FetchSavedNewsState {}

final class FetchSavedNewsLoading extends FetchSavedNewsState {}

final class FetchSavedNewsSuccessful extends FetchSavedNewsState {
  final DocumentSnapshot<Map<String, dynamic>> data;

  FetchSavedNewsSuccessful({required this.data});
}

final class FetchSavedNewsFailure extends FetchSavedNewsState {}

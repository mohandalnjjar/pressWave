part of 'fetch_saved_news_cubit.dart';

@immutable
sealed class FetchSavedNewsState {}

final class FetchSavedNewsInitial extends FetchSavedNewsState {}

final class FetchSavedNewsLoading extends FetchSavedNewsState {}

final class FetchSavedNewsSuccessful extends FetchSavedNewsState {
  final List<NewsModel> savedData;
  FetchSavedNewsSuccessful({
    required this.savedData,
  });
}

final class FetchSavedNewsFailure extends FetchSavedNewsState {
  final String message;

  FetchSavedNewsFailure({required this.message});
}

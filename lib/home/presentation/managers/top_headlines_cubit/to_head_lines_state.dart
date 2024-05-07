part of 'to_head_lines_cubit.dart';

sealed class TopHeadLinesState {}

final class TopHeadLinesInitial extends TopHeadLinesState {}

final class TopHeadLinesLoading extends TopHeadLinesState {}

final class TopHeadLinesSuccess extends TopHeadLinesState {
  final List<NewsModel> newsList;

  TopHeadLinesSuccess({required this.newsList});
}

final class TopHeadLinesFailure extends TopHeadLinesState {
  final String errorMessage;

  TopHeadLinesFailure({required this.errorMessage});
}

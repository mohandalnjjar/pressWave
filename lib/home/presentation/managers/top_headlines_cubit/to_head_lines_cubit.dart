import 'package:bloc/bloc.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/data/repos/new_repos_impl.dart';

part 'to_head_lines_state.dart';

class ToHeadLinesCubit extends Cubit<TopHeadLinesState> {
  ToHeadLinesCubit({required this.newsRepoIpm}) : super(TopHeadLinesInitial());

  final NewsRepoIpm newsRepoIpm;

  Future<void> fetchTops() async {
    emit(
      TopHeadLinesLoading(),
    );
    var result = await newsRepoIpm.fetchToHeadLineNews();

    result.fold(
      (failure) => emit(
        TopHeadLinesFailure(errorMessage: failure.errorMessage),
      ),
      (news) => emit(TopHeadLinesSuccess(newsList: news)),
    );
  }
}

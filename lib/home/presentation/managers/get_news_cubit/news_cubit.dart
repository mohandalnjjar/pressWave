import 'package:bloc/bloc.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/data/repos/home_repos_impl.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.newsRepoIpm}) : super(NewsInitial());

  final HomeRepoIpm newsRepoIpm;
  Future<void> fetchNews({required String category}) async {
    emit(NewsLoading());

    var result = await newsRepoIpm.fetchNews(category: category);

    result.fold(
      (failure) {
        emit(
          NewsFailure(errorMessage: failure.errorMessage),
        );
      },
      (news) {
        emit(
          NewsSuccess(newsList: news),
        );
      },
    );
  }
}

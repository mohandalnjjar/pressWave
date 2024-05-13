import 'package:bloc/bloc.dart';
import 'package:pressWave/home/data/models/user_model.dart';
import 'package:pressWave/home/data/repos/new_repos_impl.dart';

part 'fetch_user_data_state.dart';

class FetchUserDataCubit extends Cubit<FetchUserDataState> {
  FetchUserDataCubit({required this.newsRepoIpm})
      : super(FetchUserDataInitial());
  final NewsRepoIpm newsRepoIpm;

  Future<void> fetchUserDataMethod() async {
    emit(
      FetchUserDataLoading(),
    );
    var result = await newsRepoIpm.fetchUserData();

    result.fold(
      (failure) => emit(
        FetchUserDataFailur(errorMessage: failure.errorMessage),
      ),
      (userModel) => emit(
        FetchUserDataSuccessful(
          userModel: userModel,
        ),
      ),
    );
  }
}

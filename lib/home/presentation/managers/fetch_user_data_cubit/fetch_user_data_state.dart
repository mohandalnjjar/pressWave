part of 'fetch_user_data_cubit.dart';

sealed class FetchUserDataState {}

final class FetchUserDataInitial extends FetchUserDataState {}

final class FetchUserDataLoading extends FetchUserDataState {}

final class FetchUserDataSuccessful extends FetchUserDataState {
  final UserModel userModel;

  FetchUserDataSuccessful({required this.userModel});
}

final class FetchUserDataFailur extends FetchUserDataState {
  final String errorMessage;

  FetchUserDataFailur({required this.errorMessage});
}

part of 'fetch_user_data_cubit.dart';

sealed class FetchUserDataState {}

final class FetchUserDataInitial extends FetchUserDataState {}

final class FetchUserDataLoading extends FetchUserDataState {}

final class FetchUserDataSuccessful extends FetchUserDataState {
  final DocumentSnapshot<Map<String, dynamic>> data;
  FetchUserDataSuccessful({
    required this.data,
  });
}

final class FetchUserDataFailur extends FetchUserDataState {
  final String errorMessage;

  FetchUserDataFailur({required this.errorMessage});
}

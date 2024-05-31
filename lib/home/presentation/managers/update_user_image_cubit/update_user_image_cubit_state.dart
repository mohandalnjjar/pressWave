part of 'update_user_image_cubit_cubit.dart';

@immutable
sealed class UpdateUserImageCubitState {}

final class UpdateUserImageCubitInitial extends UpdateUserImageCubitState {}

final class UpdateUserImageCubitLoading extends UpdateUserImageCubitState {}

final class UpdateUserImageCubitSuccess extends UpdateUserImageCubitState {}

final class UpdateUserImageCubitFailure extends UpdateUserImageCubitState {
  final String message;

  UpdateUserImageCubitFailure( {required this.message});
}

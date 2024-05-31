import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pressWave/home/data/repos/home_repos_impl.dart';

part 'update_user_image_cubit_state.dart';

class UpdateUserImageCubit extends Cubit<UpdateUserImageCubitState> {
  UpdateUserImageCubit(this.newsRepoIpm) : super(UpdateUserImageCubitInitial());
  final HomeRepoIpm newsRepoIpm;

  Future<void> updateImageMethod(
      {required BuildContext context, required ImageSource imageSource}) async {
    emit(
      UpdateUserImageCubitLoading(),
    );
    var result = await newsRepoIpm.updateUserImage(
        context: context, imageSource: imageSource);

    result.fold(
      (left) => (failure) => emit(
            UpdateUserImageCubitFailure(message: failure),
          ),
      (right) => emit(
        UpdateUserImageCubitSuccess(),
      ),
    );
  }
}

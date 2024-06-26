import 'package:bloc/bloc.dart';
import 'package:pressWave/auth/data/repositories/auth_reppo_impl.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authRepoImpl}) : super(SignUpInitial());
  final AuthRepoImpl authRepoImpl;
  Future<void> signUpMethod(
      {required String email, required String password}) async {
    emit(
      SignUpLoadding(),
    );

    var result =
        await authRepoImpl.singUpUserMethod(email: email, password: password);
    result.fold(
      (failure) => emit(
        SignUpFailure(
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) => emit(
        SignUpSuccess(),
      ),
    );
  }
}

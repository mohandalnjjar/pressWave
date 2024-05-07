import 'package:dartz/dartz.dart';
import 'package:pressWave/core/errors/failuers.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> loginUserMethod(
      {required String email, required String password});

  Future<Either<Failure, void>> singUpUserMethod(
      {required String email, required String password});
}

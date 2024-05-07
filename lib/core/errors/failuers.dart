import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class FirebaseAuthExcep extends Failure {
  FirebaseAuthExcep({required super.errorMessage});

  factory FirebaseAuthExcep.fromFireException({required String errorCode}) {
    if (errorCode == 'user-not-found') {
      return FirebaseAuthExcep(errorMessage: 'No user found for that email.');
    } else if (errorCode == 'wrong-password') {
      return FirebaseAuthExcep(
          errorMessage: 'Wrong password provided for that user.');
    } else if (errorCode == 'weak-password') {
      return FirebaseAuthExcep(
          errorMessage: 'The password provided is too weak.');
    } else if (errorCode == 'email-already-in-use') {
      return FirebaseAuthExcep(
          errorMessage: 'The account already exists for that email.');
    } else {
      FirebaseAuthExcep(
          errorMessage: 'Opps some thing went wrong, please try later!');
    }
    return FirebaseAuthExcep(
        errorMessage: 'Opps some thing went wrong, please try again later!');
  }
}

///////////////////////////////////////////////////////////////////////////////////
class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'connection Time out');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'send Time out');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'receive Time out');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'bad Certificate');
      case DioExceptionType.badResponse:
        ServerFailure.fromResponse(
            dioException.response!.statusCode, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'request was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'check you enternet');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure(errorMessage: 'There is no enternet connection');
        } else {
          return ServerFailure(
              errorMessage: 'Opps some thing went wrong, please try later!');
        }

      default:
        return ServerFailure(
            errorMessage: 'Opps some thing went wrong, please try later!');
    }
    return ServerFailure(
        errorMessage: 'Opps some thing went wrong, please try later!');
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 402) {
      return ServerFailure(errorMessage: response['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
          errorMessage: 'Request not found, please try later!');
    } else if (statusCode == 500) {
      return ServerFailure(
          errorMessage: 'Internal server error, please try later!');
    } else {
      return ServerFailure(
          errorMessage: 'Opps There was an error, please try later!');
    }
  }
}

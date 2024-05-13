import 'package:dartz/dartz.dart';
import 'package:pressWave/core/errors/failuers.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/data/models/user_model.dart';

abstract class NewsRepo {
  Future<Either<Failure, List<NewsModel>>> fetchNews(
      {required String category});

  Future<Either<Failure, List<NewsModel>>> fetchToHeadLineNews();

  Future<Either<Failure, UserModel>> fetchUserData();
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pressWave/core/errors/failuers.dart';
import 'package:pressWave/core/utilities/services/api_service.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/data/models/user_model.dart';
import 'package:pressWave/home/data/repos/news_repository.dart';

class NewsRepoIpm extends NewsRepo {
  @override
  Future<Either<Failure, List<NewsModel>>> fetchNews(
      {required String category}) async {
    try {
      var newsApiData = await ApiService(dio: Dio()).getNews(
        endPointUrl: 'everything?q=${category}&apiKey=',
      );

      List<NewsModel> newsData = [];

      for (var item in newsApiData['articles']) {
        newsData.add(
          NewsModel.fromJson(item),
        );
      }

      return right(newsData);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      } else {
        return left(
          ServerFailure(
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, List<NewsModel>>> fetchToHeadLineNews() async {
    try {
      var topHeadlinesData = await ApiService(dio: Dio()).getNews(
        endPointUrl: 'top-headlines?country=us&apiKey=',
      );
      List<NewsModel> newsData = [];
      for (var items in topHeadlinesData['articles']) {
        newsData.add(
          NewsModel.fromJson(items),
        );
      }

      return right(newsData);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      } else {
        return left(
          ServerFailure(
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, UserModel>> fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    try {
      final userDocs = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      UserModel userModel = UserModel(
        userName: userDocs.get('UserName'),
        email: userDocs.get('Email'),
        timestamp: userDocs.get('CreatedAt'),
      );

      return right(userModel);
    } on FirebaseException catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

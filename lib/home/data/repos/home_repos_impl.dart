import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pressWave/core/errors/failuers.dart';
import 'package:pressWave/core/utilities/services/api_service.dart';
import 'package:pressWave/home/data/models/news_model.dart';
import 'package:pressWave/home/data/repos/home_repository.dart';

class HomeRepoIpm extends HomeRepo {
  @override
  Future<Either<Failure, List<NewsModel>>> fetchNews(
      {required String category}) async {
    try {
      var newsApiData = await ApiService(dio: Dio()).getNews(
        endPointUrl: 'everything?q=${category}&apiKey=',
      );

      List<NewsModel> newsData = [];

      for (var item in newsApiData['articles']) {
        if (item['title'] != "[Removed]") {
          newsData.add(
            NewsModel.fromJson(item),
          );
        }
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
        if (items['title'] != "[Removed]") {
          newsData.add(
            NewsModel.fromJson(items),
          );
        }
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
  Future<Either<Failure, void>> updateUserImage(
      {required BuildContext context, required ImageSource imageSource}) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User? user = firebaseAuth.currentUser;

    try {
      final ref = FirebaseStorage.instance.ref().child('UserImages').child(
            '${user!.email}.profileImage',
          );

      XFile? file = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 50,
      );

      await ref.putFile(File(file!.path));

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {
          'userImage': await ref.getDownloadURL(),
        },
      );

      return right(null);
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

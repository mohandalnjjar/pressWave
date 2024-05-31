
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pressWave/core/errors/failuers.dart';
import 'package:pressWave/home/data/models/news_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<NewsModel>>> fetchNews(
      {required String category});

  Future<Either<Failure, List<NewsModel>>> fetchToHeadLineNews();

  Future<Either<Failure, void>> updateUserImage(
      {required BuildContext context, required ImageSource imageSource});
}

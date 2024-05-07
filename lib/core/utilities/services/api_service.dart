import 'package:dio/dio.dart';

class ApiService {
  ApiService({required this.dio});

  final _baseUrl = 'https://newsapi.org/v2/';
  final _apiKey = '7a40fb0ca6e84fd2979dc637826b9070';

  final Dio dio;

  Future<Map<String, dynamic>> getNews({required String endPointUrl}) async {
    var response = await dio.get('$_baseUrl$endPointUrl$_apiKey');

    return response.data;
  }
}

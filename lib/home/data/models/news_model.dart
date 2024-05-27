import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String? author;
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final Timestamp publishedAt;
  final String? content;

  NewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromFireBase(item) {
    return NewsModel(
      author: item['author'],
      title: item['title'],
      description: item['description'],
      url: item['url'],
      urlToImage: item['urlToImage'],
      publishedAt: item['publishedAt'],
      content: item['content'],
    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: Timestamp.fromDate(json['publishedAt']),
      content: json['content'],
    );
  }
}

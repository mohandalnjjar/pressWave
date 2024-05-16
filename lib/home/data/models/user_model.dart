import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userName;
  final String userImage;

  final String email;
  final Timestamp timestamp;

  UserModel({
    required this.userImage,
    required this.userName,
    required this.email,
    required this.timestamp,
  });
}

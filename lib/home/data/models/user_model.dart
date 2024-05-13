import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userName;
  final String email;
  final Timestamp timestamp;

  UserModel({
    required this.userName,
    required this.email,
    required this.timestamp,
  });
}

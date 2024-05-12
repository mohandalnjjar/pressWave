import 'package:flutter/material.dart';

class DrawerItmeModel {
  final String title;
  final IconData icon;
  final void Function() onPressed;

  const DrawerItmeModel({
    required this.title,
    required this.icon,
    required this.onPressed,
  });
}

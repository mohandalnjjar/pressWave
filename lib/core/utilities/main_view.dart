import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pressWave/auth/presentation/views/login_View.dart';
import 'package:pressWave/home/presentation/views/root_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const RootView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}

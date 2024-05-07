import 'package:flutter/material.dart';
import 'package:pressWave/auth/presentation/widgets/sign_up_view_body.dart';

class SingUpView extends StatelessWidget {
  const SingUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingUpViewBody(),
      ),
    );
  }
}

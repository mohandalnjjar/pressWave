import 'package:flutter/material.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/home/presentation/widgets/user_profile_view_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profile',
          style: AppStyles.styleSemiBold27,
        ),
      ),
      body: const SafeArea(
        child: UserProfileViewBody(),
      ),
    );
  }
}
 
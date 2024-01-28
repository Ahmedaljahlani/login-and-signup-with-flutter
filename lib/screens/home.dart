import 'package:double_back_to_exit/double_back_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:gearandspare_login_signin/screens/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
      snackBarMessage: 'Press back again to exit',
      child: Scaffold(
        body: ProfileScreen(),
      ),
    );
  }
}

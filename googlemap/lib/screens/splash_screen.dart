import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googlemap/authentication/login_screen.dart';
import 'package:googlemap/authentication/singup_screen.dart';
import 'package:googlemap/global/global.dart';
import 'package:googlemap/manScreens/main_srceens.dart';
import 'package:lottie/lottie.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 6), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const MainScreen()),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const LoginScreen()),
            ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                  'https://assets6.lottiefiles.com/private_files/lf30_hsabbeks.json'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Welome',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

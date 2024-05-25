import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/authentication/car_info_screen.dart';
import 'package:googlemap/authentication/singup_screen.dart';
import 'package:googlemap/global/global.dart';
import 'package:googlemap/manScreens/main_srceens.dart';
import 'package:googlemap/screens/splash_screen.dart';
import 'package:googlemap/widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required.");
    } else {
      loginDriveNow();
    }
  }

  loginDriveNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          massage: "Processing,Please wait...",
        );
      },
    );
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError(
      (msg) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error:" + msg.toString());
      },
    ))
        .user;
    if (firebaseUser != null) {
      currentFirebaseUser = fAuth.currentUser;
      Fluttertoast.showToast(msg: "Login Successful.");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const MySplashScreen()),
        ),
      );
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ClipRRect(
            child: Image.asset(
              'assets/images/taxi1.jpg',
              fit: BoxFit.fitHeight,
              height: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Container(
              // width: double.infinity,
              // height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 169, 80),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Register as Driver',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Email',
                        hintStyle: const TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      validateForm();
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => SignUpScreeen()),
                          ),
                        )),
                    child: const Text(
                      'Do not have Account?Sign up here!',
                      style: TextStyle(
                          color: Color.fromARGB(218, 51, 49, 46), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

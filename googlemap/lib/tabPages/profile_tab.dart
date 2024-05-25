import 'package:flutter/material.dart';
import 'package:googlemap/global/global.dart';
import 'package:googlemap/screens/splash_screen.dart';

import '../authentication/login_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: Text('Sign out'),
      onPressed: () {
        fAuth.signOut();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const MySplashScreen()),
            ));
      },
    ));
  }
}

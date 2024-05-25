// import 'dart:html';

// import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:googlemap/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Drivers App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MySplashScreen()),
  ));
}

class MyApp extends StatefulWidget {
  final Widget? child;
  MyApp({this.child});
  static void reastartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.reastartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void reastartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Google Map',
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: ((context) => GoogleMapSreen()),
//               ),
//             )),
//         tooltip: 'Google Map',
//         child: const Icon(Icons.pin_drop_outlined),
//       ),
//     );
//   }
// }

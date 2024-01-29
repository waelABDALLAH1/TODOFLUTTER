import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/authscreen.dart';
import 'package:todo/screens/Home.dart';
import 'package:todo/auth/authscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splashscreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySplash(),
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(brightness: Brightness.dark,primaryColor: Colors.blueAccent,
          ),
    );
  }
}

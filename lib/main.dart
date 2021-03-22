import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/views/signin.dart';
import 'package:flutter_chat/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF145C9E),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF1F1F1F),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: SignUp()
    );
  }
}


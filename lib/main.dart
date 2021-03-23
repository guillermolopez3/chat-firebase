import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/autenticate.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';
import 'package:flutter_chat/views/signin.dart';
import 'package:flutter_chat/views/signup.dart';

import 'views/chat_room_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogginState();
  }

  getLogginState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
        setState(() {
          isLogin = value;
        });
    });
  }

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
      home: isLogin ? ChatRoom() : Authenticated()
    );
  }
}


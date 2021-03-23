import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/autenticate.dart';
import 'package:flutter_chat/helper/constants.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';
import 'package:flutter_chat/views/search.dart';

import '../services/auth.dart';
import '../widgets/widget.dart';
import 'signin.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethod _authMethod = AuthMethod();

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  getInfo() async{
    setState(() {
      Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Flutter'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
              _authMethod.singOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authenticated()));
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
        },
      ),
    );
  }
}

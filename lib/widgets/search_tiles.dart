import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/constants.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:flutter_chat/views/conversation_screen.dart';

import 'widget.dart';
import 'widget.dart';

class SearchTiles extends StatelessWidget {
  final String userName;
  final String mail;
  DataBaseMethod _dataBaseMethod = DataBaseMethod();

  SearchTiles({this.userName,this.mail});

  createChatRoomAndStartConversation({BuildContext context, String username}){
    String myName = sayMyName();
    if(userName != myName){
      String chatRoomId = getChatRoomId(username, myName);
      List<String> users = [username, myName];
      Map<String,dynamic> chatRoomMap = {
        'users' : users,
        'charRoomId': chatRoomId
      };
      _dataBaseMethod.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ConversationScreen()));
    }else{
      print('no te podes enviar mensajes a vos mismo');
    }

  }

  String sayMyName(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: simpleTextStyle(),),
              Text(mail,style: simpleTextStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(context: context,username: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text('Message'),
            ),
          )
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b){
  print('val a: $a , val b: $b');
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}

import 'package:flutter/material.dart';

import 'widget.dart';
import 'widget.dart';

class SearchTiles extends StatelessWidget {
  final String userName;
  final String mail;

  SearchTiles({this.userName,this.mail});

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

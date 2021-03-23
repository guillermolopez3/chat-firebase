import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:flutter_chat/widgets/search_tiles.dart';

import '../widgets/widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  DataBaseMethod _dataBaseMethod = DataBaseMethod();
  TextEditingController _searchController = TextEditingController();

  QuerySnapshot _snapshot;
  initSearc(){
    _dataBaseMethod.getUserByUserName(_searchController.text).then((value) {
      setState(() {
        _snapshot = value;
      });
    });
  }

  createChatRoomAndStartConversation(String username){
    //List<String> users = [username,];
    //_dataBaseMethod.createChatRoom(chatRoomId, chatRoomMap)
  }

  Widget searchList(){
    return _snapshot != null ? ListView.builder(
      shrinkWrap: true,
        itemCount: _snapshot.docs.length,
        itemBuilder: (ctx,idx){
          return SearchTiles(
            userName: _snapshot.docs[idx].data()['name'],
            mail: _snapshot.docs[idx].data()['email'],
          );
        }
    ): SizedBox();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.amberAccent,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: _searchController,
                    decoration: textInputDecoration('Search username...'),
                  )),
                  IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){
                     initSearc();
                  })
                ],
              ),
            ),
            searchList()
          ],
        ),
      )
    );
  }
}

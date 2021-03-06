import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethod{
  Future getUserByUserName(String username)async{
    return await FirebaseFirestore.instance.collection('users').where(
      'name', isEqualTo: username
    ).get();
  }

  Future getUserByUserEmail(String email)async{
    return await FirebaseFirestore.instance.collection('users').where(
        'email', isEqualTo: email
    ).get();
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection('users').add(userMap);
  }
  
  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection('ChatRoom').doc(chatRoomId)
        .set(chatRoomMap).catchError((e)=>print(e.toString()));
  }
}
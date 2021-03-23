import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/model/user.dart';

class AuthMethod{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user){
    return user != null ? MyUser(userId: user.uid) : null;
  }

  Future signInWithEmailAndPasswor(String mail, String pass) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      return _userFromFirebaseUser(userCredential.user);
    }catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPasswor(String mail, String pass) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      return _userFromFirebaseUser(userCredential.user);
    }catch(e){
      print(e.toString());
    }
  }

  Future resetPass(String mail) async{
    try{
     return await _auth.sendPasswordResetEmail(email: mail);
    }catch(e){
      print(e.toString());
    }
  }

  Future singOut() async{
    try{
      _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}
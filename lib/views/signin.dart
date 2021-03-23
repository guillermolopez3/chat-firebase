import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/services/auth.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:flutter_chat/views/chat_room_screen.dart';
import 'package:flutter_chat/widgets/widget.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';

class SignIn extends StatefulWidget {
  final Function toogle;
  SignIn(this.toogle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethod _auth = AuthMethod();
  DataBaseMethod _baseMethod = DataBaseMethod();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  QuerySnapshot _snapshot;

  signIn(){
    if(_formKey.currentState.validate()){
      HelperFunctions.saveEmailSharedPreference(emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      _baseMethod.getUserByUserEmail(emailTextEditingController.text).then((value) {
        _snapshot = value;
        HelperFunctions.saveUserNameSharedPreference(_snapshot.docs[0].data()['name']);
      });
      _auth.signInWithEmailAndPasswor(emailTextEditingController.text, passwordTextEditingController.text
      ).then((value){
        if(value != null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChatRoom()));
        }

      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -50,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(left: 15,right: 15),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      validator:(val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val) ? null : 'Please Provide a valid Email';
                      },
                      controller: emailTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textInputDecoration('email')
                  ),
                  TextFormField(
                      obscureText: true,
                      validator: (val){
                        return val.length > 6 ? null : 'Please Provide paswword 6+ characters';
                      },
                      controller: passwordTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textInputDecoration('password')
                  ),
                  SizedBox(height: 8,),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text('Forgot Password', style: simpleTextStyle(),),
                    ),
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){
                      signIn();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF007EF4),
                                Color(0xFF247BC5)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text('Sing In', style: mediumTextStyle(),),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Sing In with Google', style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don´t have account?', style: mediumTextStyle(),),
                      GestureDetector(
                        onTap: (){
                          widget.toogle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('Register now', style:TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline
                          ),),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}

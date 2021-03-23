import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';
import 'package:flutter_chat/widgets/widget.dart';

import '../services/auth.dart';
import '../services/auth.dart';
import 'chat_room_screen.dart';
import 'package:flutter_chat/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toogle;

  SignUp(this.toogle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  AuthMethod _auth = AuthMethod();
 

  DataBaseMethod _dataBaseMethod = DataBaseMethod();
  bool isLoading = false;
  final _key = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signMeUp(){
    if(_key.currentState.validate()){
      Map<String,String> userMapInfo = {
        'name' : userNameTextEditingController.text,
        'email': emailTextEditingController.text
      };

      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
      HelperFunctions.saveEmailSharedPreference(emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      _auth.signUpWithEmailAndPasswor(emailTextEditingController.text,
        passwordTextEditingController.text
      ).then((value){
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        _dataBaseMethod.uploadUserInfo(userMapInfo);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChatRoom()));
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ?
      Container(
        child: Center(child: CircularProgressIndicator(),),
      )
      : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -50,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(left: 15,right: 15),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               Form(
                 key: _key,
                 child: Column(
                   children: [
                     TextFormField(
                          validator:(val){
                            return val.isEmpty || val.length < 2 ? 'Please Provide a valid UserName' : null;
                          },
                         controller: userNameTextEditingController,
                         style: simpleTextStyle(),
                         decoration: textInputDecoration('username')
                     ),
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
                   ],
                 ),
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
                    signMeUp();
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
                    child: Text('Sing Up', style: mediumTextStyle(),),
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
                    Text('Already have account?', style: mediumTextStyle(),),
                    GestureDetector(
                      onTap: (){
                        widget.toogle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('SignIn now', style:TextStyle(
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
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../views/signin.dart';
import '../views/signup.dart';

class Authenticated extends StatefulWidget {
  @override
  _AuthenticatedState createState() => _AuthenticatedState();
}

class _AuthenticatedState extends State<Authenticated> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toggleView) : SignUp(toggleView);
  }
}

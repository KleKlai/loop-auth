import 'package:flutter/material.dart';
import 'package:loopAuth/screens/Authentication/sign_in.dart';
import 'package:loopAuth/screens/Authentication/signup/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      // Reverse base on current value of showSignIn
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if(showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Signup(toggleView: toggleView);
    }
    
  }
}
import 'package:flutter/material.dart';
import 'package:loopAuth/screens/Authentication/authenticate.dart';
import 'package:loopAuth/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:loopAuth/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context); //Get user from main.dart StreamProvider
    print(user);

    // Return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:loopAuth/screens/services/auth.dart';
import 'package:loopAuth/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:loopAuth/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
     // Stream Provider listen for AuthService Chances
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopAuth/models/user.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({ this.toggleView });
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _mobile;
  bool _showPassword = false;

  final _codeController = TextEditingController();

  String phone = '';

  Widget _buildMobile() {
    return TextFormField(
      decoration: new InputDecoration(
        labelText: "Mobile Number",
        hintText: '09',
        prefixIcon: Icon(
          Icons.phone_android
        ),
      ),
      // keyboardType: TextInputType.number,
      // inputFormatters: <TextInputFormatter>[
      //   WhitelistingTextInputFormatter.digitsOnly
      // ],
      maxLength: 13,
      validator: (value) {
        if (value.isEmpty) {
          return 'Mobile Number is Required';
        }

        return null;
      },
      onSaved: (value) {
        phone = value;
      },
    );
  }

  Future<bool> loginUser(String phone, BuildContext context) async {

    //Connect to firebase
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone, 
      timeout: Duration(seconds: 60), 
      verificationCompleted: (AuthCredential credential) async {

        print('Test Verification Completed');

        Navigator.of(context).pop(); //Remove Code Dialog if the phone auto retrieve the code

        AuthResult result = await _auth.signInWithCredential(credential);

        FirebaseUser user = result.user;

        if(user != null){
          print('User UID: ' + user.uid);
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => HomeScreen(user: user,)
          // ));
        } else {
          print('Something went wrong');
        }
          
        // This callback would gets called when verification is done automatically 
        
      }, 
      verificationFailed: (AuthException exception) {
        print('exceptions');
      }, 
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Give the code you received'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(

                    //TODO: make _codeController to get all the data in TextField
                    controller: _codeController,

                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Confirm'),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {

                    //TODO: make a action here 
                    final code = _codeController.text.trim();
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                      verificationId: verificationId, 
                      smsCode: code
                    );

                    AuthResult result = await _auth.signInWithCredential(credential);
                    FirebaseUser user = result.user;

                    if(user != null){
                      print('Test: ' + user.uid);
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) => HomeScreen(user: user,)
                      // ));
                    } else {
                      print('Something went wrong');
                    }

                  },
                )
              ],
            );
          }
        );
      }, 
      codeAutoRetrievalTimeout: null
    );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
            padding: EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Login via Mobile Number',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 50,),
                  _buildMobile(),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Align(
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                    elevation: 0,
                    onPressed: () {

                      if(!_formKey.currentState.validate()) {
                          return;
                        }

                      _formKey.currentState.save();

                      //TODO: Action
                      loginUser(phone, context); // Send Textfield number in LoginUser function

                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                    "Don't have an account? "
                    ),
                    InkWell(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          // TODO: Make redirection to Sign In Screen
                          widget.toggleView();
                        },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
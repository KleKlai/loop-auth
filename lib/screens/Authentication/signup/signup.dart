import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:loopAuth/screens/Authentication/signup/PersonalDetails.dart';

class Signup extends StatefulWidget {

  final Function toggleView;

  Signup({ this.toggleView });

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String _mobile, _password;

  bool _agreement       = false;
  bool _passwordSatisfy = false;
  bool _mobileSatisfy   = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  Widget _buildMobile() {
    return TextFormField(
      decoration: new InputDecoration(
        labelText: "Mobile Number",
        hintText: '09',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
      maxLength: 11,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mobile Number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _mobile = value;
      },
      onChanged: (String value) {

        if(value.length == 11){
          setState(() {
            _mobileSatisfy = true;
          });
        }

        if(value.length < 11){
          setState(() {
            _mobileSatisfy = false;
          });
        }
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: Validators.compose([
              Validators.required('Password is required'),
              Validators.patternString(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', 'Password must contain \nLower Case, Upper Case, Special Characters')
            ]),
      onSaved: (String value) {
        _password = value;
      },
      onChanged: (String value) {
        if(value.isNotEmpty){
          setState(() {
            _passwordSatisfy = true;
          });
        }
      },
    );
  }

  Widget _buildAgreement() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
            CheckboxListTile(
                title: Text('I agree with the Terms and Condition and the Privacy Policy', style: TextStyle(fontSize: 14),),
                value: _agreement,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool value) {
                    setState(() {
                        _agreement = value;
                    });
                },
                activeColor: Colors.green,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // key: _scaffoldKey,
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
                    "Let's Get Started!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Sign up via Mobile Number',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 50,),
                  _buildMobile(),
                  _buildPassword(),
                  _buildAgreement(),
                  SizedBox(height: 80),
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
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                    elevation: 0,
                    onPressed: _agreement == true && _mobileSatisfy == true && _passwordSatisfy == true ? () {
                        if(!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PersonalDetails(mobile: _mobile, password: _password),
                        ));

                      } : null,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                    'Already have an account? '
                    ),
                    InkWell(
                        child: Text(
                          'Sign In',
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
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';

class PersonalDetails extends StatefulWidget {

  //TODO: Constructor Here to Received data from signup() class
  String mobile;
  String password;

  PersonalDetails({Key key, @required this.mobile, this.password}) : super(key : key);



  @override
  _PersonalDetailsState createState() => _PersonalDetailsState(mobile, password);
}

class _PersonalDetailsState extends State<PersonalDetails> {

  //TODO: Data from PersonalDetails class
  String mobile;
  String password;
  _PersonalDetailsState(this.mobile, this.password);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _firstName, _lastName, _gender;
  int group = 1;

  Widget _buildFirstName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is Required'; 
        }

        return null;
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Last Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required'; 
        }

        return null;
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildGenderMale() {
    return Row(
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: group,
          onChanged: (value) {
            print(value);

            setState(() {
              group = value;
            });
          },
        ),
        Text('Male'),
      ],
    );
  }

  Widget _buildGenderFemale() {
    return Row(
      children: <Widget>[
        Radio(
          value: 2,
          groupValue: group,
          onChanged: (value) {
            print(value);

            setState(() {
              group = value;
            });
          },
        ),
        Text('Female'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Tell us more',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'You are one step away to your account',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30,),
                  _buildFirstName(),
                  _buildLastName(),

                  SizedBox(height: 30,),
                  Text(
                    'You Are',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  SizedBox(height: 10,),
                  GenderSelection(
                    isCircular: true,
                    selectedGenderIconBackgroundColor: Colors.indigo,
                    animationDuration: Duration(milliseconds: 400),
                    opacityOfGradient: 0.6,
                    padding: const EdgeInsets.all(3),
                    size: 130,
                    onChanged: (Gender gender){
                      print(gender);
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Align(
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                padding: EdgeInsets.all(15),
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                ),
                elevation: 0,
                onPressed: () {

                  print(_gender);
                },
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
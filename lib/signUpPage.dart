import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutter/services.dart';

// Create a Form widget.
class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();
  String serverResponse = '';
  int serverStatus;
  List pharmacies;
  String _hash="";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
     emailController.dispose();
     firstNameController.dispose();
     lastNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF151026),
      ),
      body:Form(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(100, 20, 50, 10),
      child: Container(
      width: 1200,
      //height: 000,
      decoration: BoxDecoration(),

        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,

                hintText: 'First Name',

              ),
              controller: firstNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,

                hintText: 'Last Name',

              ),
              controller: lastNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,

                hintText: 'Username',

              ),
              controller: usernameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),

            TextFormField(

                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,

                  hintText: 'Password',

                ),
                controller: passwordController
            ),



            Row(

                children: <Widget>[

                  RaisedButton(

                    child: Text('SignUp'),

                    onPressed: () {
                      _signupdata();

                    },
                  ),


                ],
                mainAxisSize: MainAxisSize.max
            ),

          ],
        ),


     // )
      )
        )

    ),
    );
  }


  Future<String>_signupdata() async {
    String firstName=(firstNameController.text).toString();
    String lastName=(lastNameController.text).toString();
    String userName=(usernameController.text).toString();
    String passwordPlain=(passwordController.text).toString();
    hash(passwordPlain);
    String password=_hash;
    print(password);
    // String email=(emailController.text).toString();

    var jsonData= json.encode(
      {
        "Firstname": firstName,
        "Lastname": lastName,
        "Username": userName,
        "Password": password,
        "JobDescription": "Patient"

      }

    );
print("sending dta"+ jsonData);
    Response response = await post( "http://10.0.2.2:3002/signup",headers: {"content-type": "application/json"},body:jsonData);
   print(response.body);
     setState(() {

      serverStatus= response.statusCode;
      if(serverStatus==404)
      {
        serverResponse="Enter a search item!";
        print(serverResponse);

      }
      else if(serverStatus==200){

        serverResponse = response.body;
        Navigator.pushNamed(context, '/');

      }
      print(serverResponse);
      print(serverResponse.length);
      List<dynamic> inst= jsonDecode(serverResponse);
      print(inst.length);
      //pharmacies=inst;

    });
  }
  Future<void> hash(pwd) async {
    String hash;
    try {
      var salt = await FlutterBcrypt.salt();
      hash = await FlutterBcrypt.hashPw(password: pwd, salt: salt);

    } on PlatformException {
      hash = 'Failed to get hash.';
    }

    if (!mounted) return;

    setState(() {
      _hash = hash;
    });
  }

}
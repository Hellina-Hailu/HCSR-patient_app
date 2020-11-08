import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';

// Create a Form widget.
class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {

  String serverResponse = '';
  int serverStatus;
  List pharmacies;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {

    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(80.0),
       child: Container(
         width: 1200,

          decoration: BoxDecoration(

          ),
         child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(

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


              hintText: 'Password',

            ),
            controller: passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),



          Row(

              children: <Widget>[
                RaisedButton(

                  child: Text('Login'),

                  onPressed: () {
                    _authenticate();

                  },
                ),
                RaisedButton(

                  child: Text('SignUp'),

                  onPressed: () {


                     Navigator.pushNamed(context, '/signup');
                  },
                ),


              ],
            //  mainAxisSize: MainAxisSize.max
          ),


        ],
      ),)
      )
    );
  }

  _authenticate() async {
    String username=(usernameController.text).toString();
    String password=(passwordController.text).toString();
    var jsonData=json.encode({
      "Username": username,
      "Password": password,

    });

    Response response = await post('http://10.0.2.2:3002/loginpatient',headers: {"content-type": "application/json"},body:jsonData);
    setState(() {

      serverStatus= response.statusCode;
      if(serverStatus==404)
      {
        serverResponse="Enter a search item!";
        print(serverResponse);

      }
      else if(serverStatus==200){

        serverResponse = response.body;
        Navigator.pushNamed(context, '/home');

      }
      print(serverResponse);
      print(serverResponse.length);


    });
  }


}

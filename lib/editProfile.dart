import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage=FlutterSecureStorage();


// Create a Form widget.
class EditProfileForm extends StatefulWidget {
  final String Firstname;
  final String Lastname;
  final String Username;
  EditProfileForm({Key key, @required this.Firstname, @required this.Username, @required this.Lastname}): super(key:key);
  @override
  EditProfileFormState createState() {
    return EditProfileFormState();
  }
}

class EditProfileFormState extends State<EditProfileForm> {

  final _formKey = GlobalKey<FormState>();
  String serverResponse = '';
  int serverStatus;

  String _hash="";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordCurrentController = TextEditingController();
  final passwordNewController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  
  @override
  void initState()  {

    super.initState();
    firstNameController.text=widget.Firstname;
    lastNameController.text=widget.Lastname;
    usernameController.text=widget.Username;


  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordCurrentController.dispose();
    passwordNewController.dispose();
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
              //initialValue: "widget.Firstname",
              decoration: InputDecoration(
                border: InputBorder.none,

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

                  hintText: 'Current Password',

                ),
                controller: passwordCurrentController
            ),
            TextFormField(

                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,

                  hintText: 'New Password',

                ),
                controller: passwordNewController
            ),



            Row(

                children: <Widget>[

                  RaisedButton(

                    child: Text('Update'),

                    onPressed: () {
                      _updatedata();

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


  Future<String>_updatedata() async {
    var userInfo= await storage.read(key: "token");
    var userID= jsonDecode(userInfo)["userData"]["userID"];
    String firstName=(firstNameController.text).toString();
    String lastName=(lastNameController.text).toString();
    String userName=(usernameController.text).toString();
    String passwordCurrentPlain=(passwordCurrentController.text).toString();
    String passwordNewPlain=(passwordNewController.text).toString();
    print(passwordNewPlain);

    var jsonData= json.encode(
      {
        "OriginalUsername": widget.Username,
        "Firstname": firstName,
        "Lastname": lastName,
        "Username": userName,
        "PasswordCurrent": passwordCurrentPlain,
        "PasswordNew": passwordNewPlain,
        "JobDescription": "Patient",
        "UserID": userID
      }

    );
print("sending data"+ jsonData);
    Response response = await post( "http://10.0.2.2:3007/updatepatinetprofile",headers: {"content-type": "application/json"},body:jsonData);
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
        Navigator.pushNamed(context, '/home');

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
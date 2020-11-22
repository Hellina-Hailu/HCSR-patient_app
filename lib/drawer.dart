import 'package:flutter/material.dart';
import 'package:flutter_app_2/editProfile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
//this is the code for the drawer that helps users navigate to different parts of the app.
//it displays options of going to the main page(home), rating services, personal account

final storage=FlutterSecureStorage();
class appDrawer extends  StatefulWidget {
  @override
  appDrawerState createState() {
    return new appDrawerState();
  }
}
class appDrawerState extends State<appDrawer> {
  @override
  Widget build(BuildContext context) {
   return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("HCSR"),

          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, "/home");
              }
          ),
          ListTile(
              leading: Icon(Icons.star),
              title: Text("Rate services"),
              onTap: () {
                Navigator.pushNamed(context, "/ratinghomepage");
              }
          ),
          ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Account"),
              onTap: () async {
              //  Navigator.pushNamed(context, "/editprofile");
                var token =await storage.read(key: "token");
                var Firstname= jsonDecode(token)["userData"]["Firstname"].toString();
                var Lastname= jsonDecode(token)["userData"]["Lastname"].toString();
                var Username= jsonDecode(token)["userData"]["Username"].toString();
              //  print(userData);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> EditProfileForm(Firstname: Firstname, Lastname: Lastname, Username: Username),
                    ));
              }
          ),



        ],

      ),


    );
  }
}
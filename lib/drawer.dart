import 'package:flutter/material.dart';

//this is the code for the drawer that helps users navigate to different parts of the app.
//it displays options of going to the main page(home), rating services, personal account, and bug reporting.
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
              onTap: () {
                Navigator.pushNamed(context, "/home");
              }
          ),
          ListTile(
              leading: Icon(Icons.report),
              title: Text("Report a bug"),
              onTap: () {
                Navigator.pushNamed(context, "/home");
              }
          ),


        ],

      ),


    );
  }
}
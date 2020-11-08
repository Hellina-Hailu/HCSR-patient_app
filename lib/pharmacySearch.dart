import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/pharmacyProfile.dart';
import 'package:http/http.dart';
import "drawer.dart";



class SearchPharmacy extends StatefulWidget {
  @override
 SearchPharmacyState createState() {
    return new SearchPharmacyState();
  }
}

class SearchPharmacyState extends State<SearchPharmacy> {

  String serverResponse = '';
  int serverStatus;
  List labs;


  final PharmacyNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    PharmacyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF151026),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(

            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Column(
                    children: <Widget>[


                      TextField(
                          decoration: InputDecoration(
                             // border: InputBorder.none,

                              hintText: 'Enter the Pharmacy Name'
                          ),

                          controller: PharmacyNameController
                      ),


                      RaisedButton(
                        child: Text("Search"),

                        onPressed: () async {
                          _makeGetRequest();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=> PharmacyProfile(pharmacy: jsonDecode(serverResponse)),
                              ));
                        },
                      ),

                    ],
                    mainAxisSize: MainAxisSize.max
                ),


               

              ],
            ),
          ),
        ),
      ),
    );
  }

  _makeGetRequest() async {
    Response response = await get(_localhost());
    setState(() {
      serverStatus = response.statusCode;
      if (serverStatus == 404) {
        serverResponse = "Enter a search item!";

      }
      else {
        serverResponse = response.body;
      }

    });
  }

  String _localhost() {
    String pharmacyname = (PharmacyNameController.text).toString();

    if (Platform.isAndroid)
      return 'http://10.0.2.2:3002/pharmacy/searchpharmacy/$pharmacyname';
    else // for iOS simulator
      return 'http://10.0.2.2:3002/pharmacy/searchpharmacy/$pharmacyname';
  }



}
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/searchResultsSpecialistTable.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import "drawer.dart";




class SpecialistSearch extends StatefulWidget {
  @override
  SpecialistSearchState createState() {
    return new SpecialistSearchState();
  }
}

class SpecialistSearchState extends State<SpecialistSearch> {

  String serverResponse = '';
  int serverStatus;
  List specialists;


  final SpecialityNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    SpecialityNameController.dispose();
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

                              hintText: 'Enter the speciality'
                          ),

                          controller: SpecialityNameController
                      ),


                      RaisedButton(
                        child: Text("Search"),

                        onPressed: () async {
                          _makeGetRequest();
                        //  Text(_getCurrentLocation().toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=> SimpleTable(jsonSample: serverResponse),
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
        print(serverResponse);
      }
      else {
        serverResponse = response.body;
      }

    });
  }

  String _localhost() {
    String specialityname = (SpecialityNameController.text).toString();
    print(specialityname);
    if (Platform.isAndroid)
      return 'http://10.0.2.2:3007/specialist/searchspeciality/$specialityname';
    else // for iOS simulator
      return 'http://10.0.2.2:3007/labratory/searchlabtest/moxal';
  }



}
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/searchResultsLabTestTable.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import "drawer.dart";



class LabTestSearch extends StatefulWidget {
  @override
 LabTestSearchState createState() {
    return new LabTestSearchState();
  }
}

class LabTestSearchState extends State<LabTestSearch> {
  String serverResponse = '';
  int serverStatus;
  List labs;

  final LabTestSearchTermController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    LabTestSearchTermController.dispose();
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

                              hintText: 'Enter the lab test name'
                          ),

                          controller: LabTestSearchTermController
                      ),


                      RaisedButton(
                        child: Text("Search"),

                        onPressed: () async {
                         await _makeGetRequest();

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
        //add error handling here when the search doesn't return successfully
        serverResponse = "Enter a search item!";
        print(serverResponse);
      }
      else {
        serverResponse = response.body;
      }

    });
  }

  String _localhost() {
    String labtestname = (LabTestSearchTermController.text).toString();
    print(labtestname);
    if (Platform.isAndroid)
      return 'http://10.0.2.2:3002/labratory/searchlabtest/$labtestname';
    else // for iOS simulator
      return 'http://10.0.2.2:3002/labratory/searchlabtest/$labtestname';
  }



}
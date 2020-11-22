import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/searchResultsTable.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import "drawer.dart";



class MedicineSearch extends StatefulWidget {
  @override
  MedicineSearchState createState() {
    return new MedicineSearchState();
  }
}

class MedicineSearchState extends State<MedicineSearch> {

  String serverResponse = '';
  int serverStatus;
  List pharmacies;
  final MedicneSearchTermController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    MedicneSearchTermController.dispose();
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

                              hintText: 'Enter the medicine name'
                          ),

                          controller: MedicneSearchTermController
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

      }
      else {
        serverResponse = response.body;
      }

    });
  }

  String _localhost() {
    String medname = (MedicneSearchTermController.text).toString();
    print(medname);
    if (Platform.isAndroid)
      return 'http://10.0.2.2:3007/pharmacy/searchmed/$medname';
    else // for iOS simulator
      return 'http://10.0.2.2:3007/pharmacy/searchmed/$medname';
  }



}
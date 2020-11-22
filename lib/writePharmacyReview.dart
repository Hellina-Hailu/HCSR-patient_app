import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/searchResultsTable.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import "drawer.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ratingHomePage.dart';

final stoarge= FlutterSecureStorage();


class PharmacyReview extends StatefulWidget {
  final int pharmacyID;
  PharmacyReview({Key key, @required this.pharmacyID}): super(key:key);
  @override
  PharmacyReviewState createState() {
    return new PharmacyReviewState();
  }
}

class PharmacyReviewState extends State<PharmacyReview> {

  String serverResponse = '';
  int serverStatus;
  List pharmacies;
  final PharmacyReviewController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    PharmacyReviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(),
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
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        hintText: 'Write your comment here',

                      ),
                      controller: PharmacyReviewController,
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

                            child: Text('Post Review'),

                            onPressed: () {
                              _postReview();
                              Navigator.pop(context);
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


  Future<String>_postReview() async {
    String comment=(PharmacyReviewController.text).toString();
  var token= await stoarge.read(key: "token");
  var userID= jsonDecode(token)["userData"]["userID"];

    var jsonData= json.encode(
        {
          "userID": userID,
          "pharmacyID":widget.pharmacyID,
          "comment": comment,


        }

    );
    print("sending dta"+ jsonData);
    Response response = await post( "http://10.0.2.2:3007/pharmacy/writereview",headers: {"content-type": "application/json"},body:jsonData);
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


    });
  }



}
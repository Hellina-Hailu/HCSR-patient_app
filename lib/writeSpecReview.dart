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


class SpecReview extends StatefulWidget {
  final int specID;
  SpecReview({Key key, @required this.specID}): super(key:key);
  @override
  SpecReviewState createState() {
    return new SpecReviewState();
  }
}

class SpecReviewState extends State<SpecReview> {

  String serverResponse = '';
  int serverStatus;
  List Specs;
  final SpecReviewController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    SpecReviewController.dispose();
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
                      controller: SpecReviewController,
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
    String comment=(SpecReviewController.text).toString();
  var token= await stoarge.read(key: "token");
  var userID= jsonDecode(token)["userData"]["userID"];

    var jsonData= json.encode(
        {
          "userID": userID,
          "specID":widget.specID,
          "comment": comment,


        }

    );
    print("sending dta"+ jsonData);
    Response response = await post( "http://10.0.2.2:3007/specialist/writereview",headers: {"content-type": "application/json"},body:jsonData);
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
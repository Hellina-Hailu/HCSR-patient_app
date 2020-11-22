import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'viewReviews.dart';
import 'writeLabReview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
final storage= FlutterSecureStorage();
class RatingLab extends StatefulWidget{
  final int labID;
  final int initialRating;
  RatingLab({Key key, @required this.labID, @required this.initialRating}): super(key:key);

  @override
  _RatingLabState createState() => _RatingLabState();

}
class _RatingLabState extends State<RatingLab>{
  var rating;
  var token;
  String serverResponse = '';
  int serverStatus;
 @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
      RatingBar(

             initialRating: widget.initialRating.toDouble(),
             minRating: 1,
             direction: Axis.horizontal,
             allowHalfRating: true,
             itemCount: 5,
             itemSize: 50,
             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
             itemBuilder: (context, _) => Icon(
               Icons.star,
               color: Colors.amber,
             ),
             onRatingUpdate: (ratingVal) {
               rating=ratingVal;

             },
           ),
      Column(
         children: <Widget>[

           FlatButton(
             child: Text("Post"),
             onPressed: () async{
               token =await storage.read(key: "token");
               var userID= jsonDecode(token)["userData"]["userID"];
               SendRatingValue(rating, userID, widget.labID);

             },
           ),
           FlatButton(
             child: Text("Write a review"),
             onPressed: ()=>{
               Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context)=> LabReview(labID: widget.labID),
                   ))
             },

           ),
           FlatButton(
             child: Text("View other reviews"),
             onPressed: ()=>{
               _getReview(widget.labID),
             Navigator.push(
             context,
             MaterialPageRoute(
             builder: (context)=> ReadReviews(reviews: jsonDecode(serverResponse)),
             ))

             },

           )

         ],

       ),



        ],




    );
  }
  Future<String> _getReview(int labID) async{
    Response response= await get ("http://10.0.2.2:3007/lab/readreviews/$labID");
    print(response.body);

    setState(() {
      serverStatus= response.statusCode;
      if(serverStatus==404)
      {
        serverResponse="Enter a search item!";


      }
      else if(serverStatus==200){

        serverResponse = response.body;
      //  Navigator.pushNamed(context, '/');
        print(serverResponse);
      }
    });

}
 Future<String> SendRatingValue(rating, userID, labID) async{
    print(rating);
    var jsonData=json.encode({"rating":rating, "userID": userID, "labID": labID});
      print(jsonData);
      Response response = await post( "http://10.0.2.2:3007/lab/rate",headers: {"content-type": "application/json"}, body:jsonData);
      print(response.body);
      setState(() {

        serverStatus= response.statusCode;
        if(serverStatus==404)
        {
          serverResponse="Enter a search item!";


        }
        else if(serverStatus==200){

          serverResponse = response.body;
          Navigator.pushNamed(context, '/');

        }


      });

    }




}

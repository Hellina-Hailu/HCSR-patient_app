import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';

class RatingServices extends StatefulWidget{
  @override
  _RatingServicesState createState() => _RatingServicesState();

}
class _RatingServicesState extends State<RatingServices>{
  var rating;
  String serverResponse = '';
  int serverStatus;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
      RatingBar(
             initialRating: 3,
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
             onPressed: (){
              // print(rating);
               SendRatingValue(rating, 22, 12);

             },
           ),
           FlatButton(
             child: Text("Write a review"),
             onPressed: ()=>{


             },

           )

         ],

       ),



        ],




    );
  }
 Future<String> SendRatingValue(rating, userID, pharmacyID) async{
    print(rating);
    var jsonData=json.encode({"rating":rating, "userID": userID, "pharmacyID": pharmacyID});
      print(jsonData);
      Response response = await post( "http://10.0.2.2:3002/pharmacy/ratepharmacy",headers: {"content-type": "application/json"}, body:jsonData);
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
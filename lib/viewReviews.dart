import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'mapHospitals.dart';

//void main() => runApp(HospitalCards());

class ReadReviews extends StatefulWidget {
  final List<dynamic> reviews;
  ReadReviews({Key key, @required this.reviews}) : super(key:key);
  @override
  _ReadReviewsState createState() => _ReadReviewsState();
}

class _ReadReviewsState extends State<ReadReviews> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xFF151026),
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {Navigator.pop(context);
              }),
          title: Text("Reviews" ),
          actions: <Widget>[

          ],
        ),
        body:  Stack(
          children: <Widget>[
          _buildReviewBoxes(context),
        ],

        ),

      ),
      debugShowCheckedModeBanner: false,
    );
  }


  Widget _buildReviewBoxes(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),

        height: 400.0,
        child: ListView(
          scrollDirection: Axis.vertical,
            children: <Widget>[
        for(int i=0; i<widget.reviews.length; i ++)
          Reviewcards(i),
    ]
        ),
      ),
    );
  }

  Widget Reviewcards(int index){

    return Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Container(
          width: 300,
          height: 400,
          // padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
             UserBox(index),
              ReviewBox(index),

            ],

          )

        ),
      ],


    );


  }

  Widget UserBox(int index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(widget.reviews[index]["Username"]),

          ],
        ),
      RatingBar(

         initialRating: widget.reviews[index]["Rating"].toDouble(),
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

         ),


      ],
    );
  }

  Widget ReviewBox(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(widget.reviews[index]["Comment"]),
      ],
    );
  }




}
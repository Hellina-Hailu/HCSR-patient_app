import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'mapHospitals.dart';

//void main() => runApp(HospitalCards());

class HospitalCards extends StatefulWidget {
  final List<dynamic> hospitals;
  final String specialistFName;
  final String specialistLName;
  final String specialistTitle;
  HospitalCards({Key key, @required this.hospitals, @required this.specialistFName, @required this.specialistLName, @required this.specialistTitle}) : super(key: key);

  @override
  _HospitalCardsState createState() => _HospitalCardsState();
}

class _HospitalCardsState extends State<HospitalCards> {

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
          title: Text(widget.specialistTitle+ " " +widget.specialistFName + " "+ widget.specialistLName+" is available at:" ),
          actions: <Widget>[

          ],
        ),
        body:  Stack(
          children: <Widget>[
          _buildCardsContainer(context),
        ],

        ),

      ),
      debugShowCheckedModeBanner: false,
    );
  }


  Widget _buildCardsContainer(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),

        height: 400.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
            children: <Widget>[
        for(int i=0; i<widget.hospitals.length; i ++)
          Hospcards(i),
    ]
        ),
      ),
    );
  }

  Widget Hospcards(int index){

    return Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Container(
          width: 300,
          height: 400,
          // padding: const EdgeInsets.all(8.0),
          child:  _HospInfoboxes(
              "https:", index,
              widget.hospitals[index]["Latitude"], widget.hospitals[index]["Longitude"],widget.hospitals[index]["HospitalName"]
          ),

        ),
      ],


    );


  }

  Widget _HospInfoboxes(String _image,int index,  double lat,double long,String HospName) {
    return  GestureDetector(
      onTap: () {

      },

      child:Container(

        child: new FittedBox(
          child: Material(
              color:  Color(0xFF151026),
              borderRadius: BorderRadius.circular(24.0),


              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HospInfoBox(HospName, index),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget HospInfoBox(String hospName, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(hospName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
          //this is to display the rating for the hospital
        ),
        SizedBox(height:5.0),
        Column(
          children: <Widget>[
            Container(
              child: Text("Working hours: "+ widget.hospitals[index]["WorkingHour"],
                style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,),
            ),
            ),
            Container(
              child: Text("Working Days: "+ widget.hospitals[index]["WorkingDay"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,),
              ),
            ),
          ],

        ),
        Row(
          children: <Widget>[

         Column(
           children: <Widget>[
             SizedBox(height: 20),
             Text("Hospital Contact",style: TextStyle(
               color: Colors.white,
               fontSize: 18.0,
             ), ),
             Column(
               children: <Widget>[
                 Container(
                     child: Text(
                       widget.hospitals[index]["City"],
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 18.0,
                       ),
                     )),
                 Container(
                     child: Text(
                       ", Woroda "+  widget.hospitals[index]["Woreda"].toString(),
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.bold),
                     )),

                 Container(
                     child: Text(
                       "Referral "+ widget.hospitals[index]["Referral"].toString(),
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.bold),
                     )),
                 Container(
                     child: Text(
                       widget.hospitals[index]["PhoneNo"].toString(),
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.bold),
                     )),
                 RaisedButton(
                   child: Text("Show location"),

                   onPressed: () async {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context)=> mapHospitals(selectedHospital: widget.hospitals[index],)
                         ));
                   },

                 )
               ],

             )

           ],
         ),

           // SizedBox(height:5.0),
          ],
        ),

      ],
    );
  }




}
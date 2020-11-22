import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'rate_lab.dart';
import 'drawer.dart';

class LabProfile extends StatefulWidget {
  final List<dynamic> lab;

  LabProfile({Key key, @required this.lab}) : super(key: key);

  @override
  _LabProfileState createState() => _LabProfileState();
}

class _LabProfileState extends State<LabProfile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF151026),
      ),
        body:  Stack(
          children: <Widget>[

            _buildLabProfileContainer(context),
        ],

        ),

      );
  }


  Widget _buildLabProfileContainer(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
       // width: 100,
        //color: Colors.green,
        height: 400.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
            children: <Widget>[
        for(int i=0; i<widget.lab.length; i ++)
          Labcards(i),
    ]
        )
        ,

      ),
    );
  }
  Widget _boxes(String _image,int index,  double lat,double long,String LabName) {
    return  GestureDetector(
      onTap: () {

      },

      child:Container(

        child: new FittedBox(
          child: Material(
              color:  Color(0xFF151026),
              //elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              //shadowColor: Color(0x802196F3),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LabDetailsContainer(LabName, index),
                    ),
                  ),


                ],)
          ),
        ),
      ),
    );
  }

  Widget LabDetailsContainer(String LabName, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(LabName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),

        SizedBox(height:5.0),

        Row(
          children: <Widget>[

         Column(
           children: <Widget>[
             SizedBox(height: 20),
             Text("Lab Info",style: TextStyle(
               color: Colors.white,
               fontSize: 18.0,
             ), ),
             Column(
               children: <Widget>[
                 Container(
                     child: Text(
                       widget.lab[index]["City"],
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 18.0,
                       ),
                     )),
                 Container(
                     child: Text(
                       ", Woroda "+  widget.lab[index]["Woreda"].toString(),
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.bold),
                     )),


                 Container(
                     child: Text(
                       widget.lab[index]["PhoneNo"].toString(),
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.bold),
                     )),

               ],

             ),
             SizedBox(height:5.0),
             Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: <Widget>[

                     RatingLab(labID: widget.lab[index]["LabID"], initialRating: widget.lab[index]["Rating"]),

                   ],
                 )),



           ],
         ),

           // SizedBox(height:5.0),
          ],
        ),

      ],
    );
  }
  Widget Labcards(int index){

    return Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Container(
          width: 300,
          height: 400,
          // padding: const EdgeInsets.all(8.0),
          child:  _boxes(
              "https:", index,
              widget.lab[index]["Latitude"], widget.lab[index]["Longitude"],widget.lab[index]["LabName"]
          ),

        ),
      ],


    );


  }



}
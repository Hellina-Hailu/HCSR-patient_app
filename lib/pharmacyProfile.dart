import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'rate_services.dart';
import 'drawer.dart';

class PharmacyProfile extends StatefulWidget {
  final List<dynamic> pharmacy;

  PharmacyProfile({Key key, @required this.pharmacy}) : super(key: key);

  @override
  _PharmacyProfileState createState() => _PharmacyProfileState();
}

class _PharmacyProfileState extends State<PharmacyProfile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF151026),
      ),
        body:  Stack(
          children: <Widget>[

            _buildPharmacyProfileContainer(context),
        ],

        ),

      );
  }


  Widget _buildPharmacyProfileContainer(BuildContext context) {
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
        for(int i=0; i<widget.pharmacy.length; i ++)
          Pharmacycards(i),
    ]
        )
        ,

      ),
    );
  }
  Widget _boxes(String _image,int index,  double lat,double long,String PharmacyName) {
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
                      child: PharmacyDetailsContainer(PharmacyName, index),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget PharmacyDetailsContainer(String PharmacyName, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(PharmacyName,
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
             Text("Pharmacy Info",style: TextStyle(
               color: Colors.white,
               fontSize: 18.0,
             ), ),
             Column(
               children: <Widget>[
                 Container(
                     child: Text(
                       widget.pharmacy[index]["City"],
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 18.0,
                       ),
                     )),
                 Container(
                     child: Text(
                       ", Woroda "+  widget.pharmacy[index]["Woreda"].toString(),
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18.0,
                           fontWeight: FontWeight.bold),
                     )),


                 Container(
                     child: Text(
                       widget.pharmacy[index]["PhoneNo"].toString(),
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

                     RatingServices(),

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
  Widget Pharmacycards(int index){

    return Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Container(
          width: 300,
          height: 400,
          // padding: const EdgeInsets.all(8.0),
          child:  _boxes(
              "https:", index,
              widget.pharmacy[index]["Latitude"], widget.pharmacy[index]["Longitude"],widget.pharmacy[index]["PharmacyName"]
          ),

        ),
      ],


    );


  }



}
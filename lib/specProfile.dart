import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'rate_spec.dart';
import 'drawer.dart';

class SpecProfile extends StatefulWidget {
  final List<dynamic> spec;

  SpecProfile({Key key, @required this.spec}) : super(key: key);

  @override
  _SpecProfileState createState() => _SpecProfileState();
}

class _SpecProfileState extends State<SpecProfile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF151026),
      ),
        body:  Stack(
          children: <Widget>[

            _buildSpecProfileContainer(context),
        ],

        ),

      );
  }


  Widget _buildSpecProfileContainer(BuildContext context) {
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
        for(int i=0; i<widget.spec.length; i ++)
          SpecCards(i),
    ]
        )
        ,

      ),
    );
  }
  Widget _boxes(String _image,int index,  double lat,double long,String SpecName) {
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
                      child: SpecDetailsContainer(SpecName, index),
                    ),
                  ),


                ],)
          ),
        ),
      ),
    );
  }

  Widget SpecDetailsContainer(String SpecName, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(SpecName,
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text("Specialist info",
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
                Column(
                  children: <Widget>[
                    Container(
                        child: Text("Title: "+widget.spec[index]["Title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )),
                    Container(
                        child:  Text("First Name: "+widget.spec[index]["FirstName"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text("Last Name: "+widget.spec[index]["LastName"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text("Speciality: "+widget.spec[index]["Speciality"],
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

                     RatingSpec(specID: widget.spec[index]["SpecID"], initialRating: widget.spec[index]["Rating"]),

                   ],
                 )),



           ],
         ),

           // SizedBox(height:5.0),
          ],
        ),

      ],
    )])
    ]);
  }
  Widget SpecCards(int index){

    return Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Container(
          width: 300,
          height: 400,
          // padding: const EdgeInsets.all(8.0),
          child:  _boxes(
              "https:", index,
              widget.spec[index]["Latitude"], widget.spec[index]["Longitude"],widget.spec[index]["FirstName"]
          ),

        ),
      ],


    );


  }



}
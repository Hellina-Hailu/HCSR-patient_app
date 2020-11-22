import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'specProfile.dart';
import 'package:http/http.dart';
import "drawer.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import 'rate_services.dart';


class SearchSpecialist extends StatefulWidget {
  @override
  SearchSpecialistState createState() {
    return new SearchSpecialistState();
  }
}

class SearchSpecialistState extends State<SearchSpecialist> {

  String serverResponse = '';
  String topRated='';
  int serverStatus;
  List labs;


  final SpecialistNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    SpecialistNameController.dispose();
    super.dispose();
  }
  @override
  void initState() {

    super.initState();
    _getTopRatedSpecialists();

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
        child: Column(
          children: <Widget>[
            Align(
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

                                hintText: 'Enter the First Name'
                            ),

                            controller: SpecialistNameController
                        ),


                        RaisedButton(
                          child: Text("Search"),

                          onPressed: () async {
                            await _makeGetRequest();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context)=> SpecProfile(spec: jsonDecode(serverResponse)),
                                ));
                          },
                        ),



                      ],

                    ),



                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text("Top Rated Specialists"),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                //  color: Colors.yellow,
                height: 300.0,
                child: ListView(
                    scrollDirection: Axis.horizontal,

                    children: <Widget>[
                      //display top rated labs here.


                      _buildSpecProfileContainer(topRated),

                    ]
                ),
              ),
            ),


          ],

        )





      ),
    );
  }

  _getTopRatedSpecialists() async{
    print("getting top rated");
    Response response= await get("http://10.0.2.2:3007/specialist/spec/toprated");
    setState(() {
      serverStatus = response.statusCode;
      if (serverStatus == 404) {
       topRated = "Enter a search item!";

      }
      else {
        topRated = response.body;
        print(topRated);
      }

    });


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
    String specname = (SpecialistNameController.text).toString();

    if (Platform.isAndroid)
      return 'http://10.0.2.2:3007/specialist/searchspec/$specname';
    else // for iOS simulator
      return 'http://10.0.2.2:3007/specialist/searchspec/$specname';
  }

  Widget _buildSpecProfileContainer(String toprated) {
    var specInfo=jsonDecode(toprated);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: 500,
        //color: Colors.green,
        height: 300.0,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for(int i=0; i<specInfo.length; i ++)
                SpecCards(i, specInfo),
            ]
        )
        ,

      ),
    );

  }

  Widget SpecCards(int index, List<dynamic> info)
  {

    return Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Container(
          width: 200,
          height: 300,
          // padding: const EdgeInsets.all(8.0),
          child:  _boxes(index,info),

        ),
      ],


    );

  }

  Widget _boxes(int index, List<dynamic> info) {

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
                      child: SpecDetailsContainer(index, info),
                    ),
                  ),


                ],)
          ),
        ),
      ),
    );
  }

  Widget SpecDetailsContainer(int index, List<dynamic> info) {
    print("info");
    print(info);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
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
                        child: Text("Title: "+info[index]["Title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )),
                    Container(
                        child:  Text("First Name: "+info[index]["FirstName"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text("Last Name: "+info[index]["LastName"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text("Speciality: "+info[index]["Speciality"],
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

                        RatingBar(

                          initialRating: info[index]["Rating"].toDouble(),
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
                    )),



              ],
            ),

            // SizedBox(height:5.0),
          ],
        ),

      ],
    );
  }





}
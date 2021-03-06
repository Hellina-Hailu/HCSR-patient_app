import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_2/pharmacyProfile.dart';
import 'package:http/http.dart';
import "drawer.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import 'rate_services.dart';


class SearchPharmacy extends StatefulWidget {
  @override
 SearchPharmacyState createState() {
    return new SearchPharmacyState();
  }
}

class SearchPharmacyState extends State<SearchPharmacy> {

  String serverResponse = '';
  String topRated='';
  int serverStatus;
  List labs;


  final PharmacyNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    PharmacyNameController.dispose();
    super.dispose();
  }
  @override
  void initState() {

    super.initState();
    _getTopRatedPharmacies();

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

                                hintText: 'Enter the Pharmacy Name'
                            ),

                            controller: PharmacyNameController
                        ),


                        RaisedButton(
                          child: Text("Search"),

                          onPressed: () async {
                            await _makeGetRequest();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context)=> PharmacyProfile(pharmacy: jsonDecode(serverResponse)),
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
            Text("Top Rated Pharmacies"),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                //  color: Colors.yellow,
                height: 300.0,
                child: ListView(
                    scrollDirection: Axis.horizontal,

                    children: <Widget>[
                      //display top rated pharmacies here.
                      //   PharmacyProfile(pharmacy: jsonDecode(topRated)),

                      _buildPharmacyProfileContainer(topRated),

                    ]
                ),
              ),
            ),


          ],

        )





      ),
    );
  }

  _getTopRatedPharmacies() async{
    Response response= await get("http://10.0.2.2:3007/pharmacy/toprated");
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
    String pharmacyname = (PharmacyNameController.text).toString();

    if (Platform.isAndroid)
      return 'http://10.0.2.2:3007/pharmacy/searchpharmacy/$pharmacyname';
    else // for iOS simulator
      return 'http://10.0.2.2:3007/pharmacy/searchpharmacy/$pharmacyname';
  }
  Widget _buildPharmacyProfileContainer(String toprated) {
    var pharmacyInfo=jsonDecode(toprated);
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
              for(int i=0; i<pharmacyInfo.length; i ++)
                PharmacyCards(i, pharmacyInfo),
            ]
        )
        ,

      ),
    );

  }

  Widget PharmacyCards(int index, List<dynamic> info)
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
                      child: PharmacyDetailsContainer(index, info),
                    ),
                  ),


                ],)
          ),
        ),
      ),
    );
  }

  Widget PharmacyDetailsContainer(int index, List<dynamic> info) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(info[index]["PharmacyName"],
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
                          info[index]["City"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )),
                    Container(
                        child: Text(
                          ", Woroda "+  info[index]["Woreda"].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Text(
                         info[index]["PhoneNo"].toString(),
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
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'drawer.dart';
import 'package:json_table/json_table.dart';
import 'hospitalDetails.dart';
class SimpleTable extends StatefulWidget {
  final String jsonSample;
  SimpleTable({Key key, @required this.jsonSample}) : super(key: key);

  @override
  _SimpleTableState createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {

  String serverResponse = '';
  int serverStatus;
  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(widget.jsonSample);
    print("in json file now");
    print(json);
    var columns= [
      JsonTableColumn("Title", label: "Title"),
      JsonTableColumn("FirstName", label: "First Name"),
      JsonTableColumn("LastName", label: "Last Name"),

   // JsonTableColumn("Amount", label: "Amount")
    ];
    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF151026),
      ),
      body: SingleChildScrollView(

        padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
        child: Container(
          child: Column(
            children: [

              JsonTable(
                json,
                columns: columns,
                showColumnToggle: true,
                allowRowHighlight: true,
                rowHighlightColor: Color(0xFF151026).withOpacity(0.6),
                paginationRowCount: 10,
                onRowSelect: (index, map) {
                  print(index);
                  print(map);
                  //get the hospitals for the specialist
                  _makeGetRequest(map["SpecID"]);
                  //send the data to the maps page.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=> HospitalCards(specialistFName: map["FirstName"], specialistLName: map["LastName"], specialistTitle: map["Title"], hospitals:  jsonDecode(serverResponse)),

                      ));
                  delete(serverResponse);
                },
              ),
              SizedBox(
                height: 40.0,
              ),

            ],
          )

        ),
      ),

    );
  }
  _makeGetRequest(specialist) async {
    Response response = await get(_localhost(specialist));
    setState(() {
      serverStatus = response.statusCode;
      if (serverStatus == 404) {
        serverResponse = "Enter a search item!";
        print(serverResponse);
      }
      else {
        serverResponse = response.body;
      }
      print("you are seeing this");
      print(specialist);
      print(serverResponse);
      print(serverResponse.length);
      List<dynamic> inst = jsonDecode(serverResponse);
      //  searchResult=inst;
      print(inst);
    //  specialists = inst;
    });
  }

  String _localhost(specialist) {

    if (Platform.isAndroid)
      return 'http://10.0.2.2:3007/specialist/$specialist';
    else // for iOS simulator
      return 'http://10.0.2.2:3007/labratory/searchlabtest/moxal';
  }



}
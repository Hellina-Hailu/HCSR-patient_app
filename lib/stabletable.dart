import 'dart:convert';
import 'drawer.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'mapss.dart';
class SimpleTable extends StatefulWidget {
  final String jsonSample;
  SimpleTable({Key key, @required this.jsonSample}) : super(key: key);

  @override
  _SimpleTableState createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {


  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(widget.jsonSample);

    return Scaffold(
      drawer: appDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
            child: Column(
              children: [
                JsonTable(
                  json['PharmacyData'],
                  showColumnToggle: true,
                  allowRowHighlight: true,
                  rowHighlightColor: Colors.blue[500].withOpacity(0.7),
                  paginationRowCount: 10,
                  onRowSelect: (index, map) {
                    print(index);
                    print(map["PharmacyID"]);

                    //send the data to the maps page.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> mapsPharmacy(selectedPharmacy: map),
                        ));
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


}
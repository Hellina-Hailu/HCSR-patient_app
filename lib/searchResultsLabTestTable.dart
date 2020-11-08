import 'dart:convert';
import 'drawer.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'mapsLab.dart';
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
    var columns= [JsonTableColumn("LabName", label: "Laboratory Name"),
    JsonTableColumn("City", label: "City"),
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
                json['LaboratoryData'],
                columns: columns,
                showColumnToggle: true,
                allowRowHighlight: true,
                rowHighlightColor: Color(0xFF151026).withOpacity(0.6),
                paginationRowCount: 10,
                onRowSelect: (index, map) {


                  //send the data to the maps page.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=> mapsLaboratory(selectedLaboratory: map),
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
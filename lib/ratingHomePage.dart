import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class RatingHomePage extends StatefulWidget{
  @override
  _RatingHomePage createState() => _RatingHomePage();

}
class _RatingHomePage extends State<RatingHomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: appDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xFF151026),
        ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
          child: Align(
              alignment: Alignment.topCenter,
                 child: SizedBox(
                   width: 500,
                     child: Column(
                       children: <Widget>[
                         RaisedButton(
                           child: Text("Pharmacy"),
                           onPressed: ()=>{
                            Navigator.pushNamed(context, '/searchpharmacy')

                           },
                         ),
                         RaisedButton(
                           child: Text("Laboratory"),
                           onPressed: ()=>{
                             Navigator.pushNamed(context, '/searchlab')
                             },
                         ),
                         RaisedButton(
                           child: Text("Specialist"),
                           onPressed: ()=>{
                             Navigator.pushNamed(context, '/searchspecialist')

                             },
                         )

      ],




    ))))





    );
  }

}
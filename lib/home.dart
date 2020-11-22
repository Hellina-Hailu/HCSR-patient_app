import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
final storage=FlutterSecureStorage();
class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  var value;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
     drawer: appDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF151026),
      ),
     body:Padding(
      padding: const EdgeInsets.all(32.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Column(
                  children: <Widget>[



                    RaisedButton(
                      child: Text('Medicine'),

                      onPressed: () {
                     // value= await storage.read(key: 'token');
                     // print(value);
                        Navigator.pushNamed(context, '/medicineSearch');

                      },
                    ),



                    RaisedButton(
                          child: Text('Labratory Test'),

                        onPressed: () {
                            Navigator.pushNamed(context, '/labTestSearch');

                        },
                      ),

                    RaisedButton(
                      child: Text('Specialist'),

                      onPressed: () {
                        Navigator.pushNamed(context, '/specialistSearch');
                       },
                    ),
                    //RatingServices(),

                  ],
                  mainAxisSize: MainAxisSize.max
              ),




            ],
          ),
        ),
      ),
    ),
    );
  }

}
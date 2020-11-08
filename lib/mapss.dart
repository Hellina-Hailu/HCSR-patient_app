import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:location/location.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";


class mapsPharmacy extends StatefulWidget {
  final Map selectedPharmacy;
  mapsPharmacy({Key key, @required this.selectedPharmacy}) : super(key: key);

  @override
  _mapsPharmacyState createState() => _mapsPharmacyState();
}

class _mapsPharmacyState extends State<mapsPharmacy> {
  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  //GoogleMapController _controller;
  Completer<GoogleMapController> _controllers =Completer();
  static LatLng _currentPosition;
  LocationData _currentLocations;
  Location location;
  GoogleMapPolyline _googleMapPolyline =
  new GoogleMapPolyline(apiKey: "API KEY");


  @override
  void initState() {

    super.initState();
    _getCurrentLocation();

  }


  //Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  LatLng _mapInitLocation = LatLng(9.12,38.70);


  bool _loading = false;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controllers.complete(controller);//;= controller;
    });
  }

  //Get polyline with Location (latitude and longitude)
  _getPolylinesWithLocation(LatLng _pharmacyLocation, _currentLocation ) async {
    _setLoadingMenu(true);
    List<LatLng> _coordinates =
    await _googleMapPolyline.getCoordinatesWithLocation(
        origin: _currentLocation,
        destination: _pharmacyLocation,
        mode: RouteMode.driving);

    setState(() {
      _polylines.clear();
    });
    _addPolyline(_coordinates);
    _setLoadingMenu(false);
  }



  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color:  Color(0xFF151026),
        points: _coordinates,
        width: 10,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }

  _setLoadingMenu(bool _status) {
    setState(() {
      _loading = _status;
    });
  }
  _getCurrentLocation() async {

    location= new Location();

    _currentLocations= await location.getLocation();
    setState(() {
      _currentPosition= LatLng(_currentLocations.latitude,_currentLocations.longitude);
      print(_currentPosition.longitude);

    });




  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xFF151026),
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {Navigator.pop(context);
              }),
          title: Text(widget.selectedPharmacy["PharmacyName"]),
          actions: <Widget>[

          ],
        ),
        body: _currentPosition==null ? Container(child: Center(child:Text('loading map..', style: TextStyle(fontFamily: 'Avenir-Medium', color: Colors.grey[400]),),),)
        : Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            _buildPharmacyDetailsContainer(),
          ],

        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _loading
            ? Container(
          color: Colors.black.withOpacity(0.75),
          child: Center(
            child: Text(
              'Drawing Route...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        )
            : Container(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildGoogleMap(BuildContext context)
  {
    return Container(
      child: LayoutBuilder(
        builder: (context, cont) {
          return Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 250,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  myLocationButtonEnabled: false,
                  polylines: Set<Polyline>.of(_polylines.values),
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 15,
                  ),
          markers: {Marker(
            markerId: MarkerId(widget.selectedPharmacy["PharmacyName"]),
            position: LatLng(widget.selectedPharmacy["Latitude"],
                widget.selectedPharmacy["Longitude"]),
            infoWindow: InfoWindow(
                title: widget.selectedPharmacy["PharmacyName"]),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              1
            ),), Marker(
            markerId: MarkerId("currentPosition"),
            position: LatLng(_currentPosition.latitude,_currentPosition.longitude),
            infoWindow: InfoWindow(title: "Your location"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,

            ),)
          }
                ),
              ),
             Expanded(
                child: Align(

                    alignment: Alignment.center,
                    child: Container(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      color:  Color(0xFF151026),
                      child:       _buildPharmacyDetailsContainer(),


                    )),
              ),
            ],
          );
        },
      ),
    );

  }
  Widget _buildPharmacyDetailsContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        height: 170.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 50.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _PharmacyInfoBox(
                  "https:",
                  widget.selectedPharmacy["Latitude"], widget.selectedPharmacy["Longitude"],widget.selectedPharmacy["PharmacyName"]),
            ),

          ],
        ),
      ),
    );
  }
  Widget _PharmacyInfoBox(String _image, double lat,double long,String PharmacyName) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(_currentPosition.latitude,_currentPosition.longitude);
        _getPolylinesWithLocation( LatLng(_currentPosition.latitude,_currentPosition.longitude), LatLng(lat,long));

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
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PharmacyDetailContainer(PharmacyName),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget PharmacyDetailContainer(String pharmacyName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(pharmacyName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
            //put the rating for the pharmacy here
        ),
        SizedBox(height:5.0),
        Row(
          children: <Widget>[
            Container(
                child: Text(
                  widget.selectedPharmacy["City"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                )),
            Container(
                child: Text(
                  ", Woroda "+  widget.selectedPharmacy["Woreda"].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )),

            SizedBox(height:5.0),
          ],
        ),   Container(
            child: Text(
              "Branch "+ widget.selectedPharmacy["Branch"].toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
        Container(
            child: Text(
              widget.selectedPharmacy["PhoneNo"].toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),

      ],
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controllers.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
// method definition

}

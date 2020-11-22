import 'package:flutter/material.dart';
import 'labSearch.dart';
import 'specSearch.dart';
import 'home.dart';
import 'medicineSearch.dart';
import 'labTestSearch.dart';
import 'specialistSearch.dart';
import 'login.dart';
import 'signUpPage.dart';
import 'ratingHomePage.dart';
import 'pharmacySearch.dart';
import 'writePharmacyReview.dart';
import 'viewReviews.dart';
import 'editProfile.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'HCSR',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/signup': (context)=>SignUpForm(),
        '/home': (context)=>Home(),
        '/medicineSearch': (context)=>MedicineSearch(),
        '/labTestSearch': (context)=>LabTestSearch(),
        '/specialistSearch': (context)=> SpecialistSearch(),
        '/ratinghomepage': (context)=> RatingHomePage(),
        '/searchpharmacy': (context)=> SearchPharmacy(),
        '/searchlab': (context)=> SearchLaboratory(),
        '/searchspecialist': (context)=> SearchSpecialist(),
        '/writePharmacyReview': (context)=> PharmacyReview(),
       // '/editprofile': (context)=> EditProfileForm(),
      },
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFF151026),     //  <-- dark color
        textTheme: ButtonTextTheme.primary,),
          appBarTheme: AppBarTheme(
            color: Color(0xFF151026),

          )),
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),

        ),
        body: LoginForm(),
      ),
    );
  }
}
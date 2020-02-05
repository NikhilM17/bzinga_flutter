import 'package:bzinga/authentication/MobileNumber.dart';
import 'package:bzinga/tour/location_access.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF202329),
        accentColor: Colors.amber,
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.normal, buttonColor: Color(0xFFF29F05)),
        fontFamily: 'Raleway',
      ),
      home: LocationAccess(),
    );
  }
}
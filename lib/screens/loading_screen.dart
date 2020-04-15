import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Lesson 152: call getLocation from initState
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  void getLocation() async {
    // Lesson 154: moved getLocation contents to location.dart
    Location userLocation = Location();
    // Lesson 154: in order to wait for the location, we need the class to return a Future
    await userLocation.getCurrentLocation();
    // After it is finished, we can print the values returned
    print(userLocation.lat);
    print(userLocation.lon);
    double latValue = userLocation.lat;
    double lonValue = userLocation.lon;
    // http://api.openweathermap.org/data/2.5/weather?lat=37.4219983&lon=-122.084&appid=6d3a717320d3d4ded3be9c990f9d94a6&units=metric
  }

  void getData() async {
    Response response = await get('https://jsonplaceholder.typicode.com/albums/1');
    print(response.body);
  }

  // Lesson 153: catch exceptions
  @override
  /*
  Widget build(BuildContext context) {
    String myMargin = 'fiets';
    try {
      // Try to turn this margin to a double
      double myMarginAsADouble = double.parse(myMargin);
      return Scaffold(
        body: Container(
          color: Colors.red,
          margin: EdgeInsets.all(
            myMarginAsADouble,
          ),
        ),
      );
    // If it fails, catch & print the error and provide an alternative
    } catch (e) {
      print(e);
      return Scaffold(
        body: Container(
          color: Colors.green,
          margin: EdgeInsets.all(
            20.0,
          ),
        ),
      );
    }
  }
  */

  // Lesson 153: shorter version
  Widget build(BuildContext context) {
    String myMargin = 'ja';
    // Create an empty variable
    double myMarginAsADouble;
    Color containerColor;
    // Lesson 156: get weather data
    getData();

    try {
      // Try to assign a value, and if it works, do something else as well
      myMarginAsADouble = double.parse(myMargin);
      containerColor = Colors.green;
      // If it fails, print the error (and set a default value, or use the Null Aware operator below)
    } catch (e) {
      print(e);
      // myMarginAsADouble = 40;
    }

    return Scaffold(
      body: Container(
        color: containerColor ?? Colors.red,
        margin: EdgeInsets.all(
          // Alternative to the above/catch construct above:
          // ?? means: If variable has a value, use it, otherwise use default value (Null Aware operator)
          myMarginAsADouble ?? 40.0,
        ),
        child: Center(
          child: Text('hallo'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';
import './location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '6d3a717320d3d4ded3be9c990f9d94a6';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Lesson 158: create variables on State level to store lat & lon
  double latValue;
  double lonValue;
  // Lesson 152: call getLocation from initState
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // Lesson 154: moved getLocation contents to location.dart
    Location userLocation = Location();
    // Lesson 154: in order to wait for the location, we need the class to return a Future
    await userLocation.getCurrentLocation();
    // After it is finished, we can print the values returned
    // print(userLocation.lat);
    // print(userLocation.lon);
    // Lesson 158: set lat & lon values
    latValue = userLocation.lat;
    lonValue = userLocation.lon;
    // http://api.openweathermap.org/data/2.5/weather?lat=37.4219983&lon=-122.084&appid=6d3a717320d3d4ded3be9c990f9d94a6&units=metric
    // Lesson 158: Call getData after await userlocation, to prevent empty lat & lon values
    // getData();
    // Lesson 158: combine getLocation and getData in a networkHelper
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latValue&lon=$lonValue&appid=$apiKey&units=metric');

    // Lesson 158: get weatherData from NetworkHelper using its getData method
    var weatherData = await networkHelper.getData();

    // Lesson 159: When all is finished, move to the next screen, and pass on the weatherData to it
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));

    // Lesson 158: moved variables gotten from weaterData to location_screen.dart, to tidy up the loading screen
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
    String myMargin = 'fout';
    // Create an empty variable
    double myMarginAsADouble;
    Color containerColor;

    try {
      // Try to assign a value, and if it works, do something else as well
      myMarginAsADouble = double.parse(myMargin);
      containerColor = Colors.green;
      // If it fails, print the error (and set a default value, or use the Null Aware operator below)
    } catch (e) {
      //print(e);
      // myMarginAsADouble = 40;
    }

    return Scaffold(
      body: Container(
        color: containerColor ?? Colors.black,
        margin: EdgeInsets.all(
          // Alternative to the above/catch construct above:
          // ?? means: If variable has a value, use it, otherwise use default value (Null Aware operator)
          myMarginAsADouble ?? 0.0,
        ),
        child: Center(
          // Lesson 159
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}

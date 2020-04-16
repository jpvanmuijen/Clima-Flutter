import 'package:flutter/material.dart';
import './location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
import 'dart:async';
import 'error_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Lesson 152: call getLocation from initState
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // Lesson 162: moved getWeather to weather.dart
    // Create new WeahterModel here and get the locationWeather (using await, because it can return data at any time)
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
    /*
    try {
      var weatherData = await Future.value(weatherModel.getLocationWeather())
          .timeout(const Duration(seconds: 3));
      // Lesson 159: When all is finished, move to the next screen, and pass on the weatherData to it
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(weatherData);
      })); 
      // Lesson 158: moved variables gotten from weaterData to location_screen.dart, to tidy up the loading screen
    } on TimeoutException catch (e) {
      print(e);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ErrorScreen();
      }));
    }
    */
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

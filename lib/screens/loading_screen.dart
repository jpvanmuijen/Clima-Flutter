import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Lesson 152: call getLocation from initState
  void initState() {
    super.initState();
    getLocation();
  }

  // Lesson 150: Add async to the method
  // Only high accuracy works, Android manifest needs both coarse and fine permissions
  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(''),
    );
  }
}

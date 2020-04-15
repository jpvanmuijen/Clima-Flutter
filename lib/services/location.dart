import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double lon;
  // Lesson 150: Add async to the method
  // Only high accuracy works, Android manifest needs both coarse and fine permissions
  // Lesson 154: this class should return a Future, because it has to wait for the output below
  Future<void> getCurrentLocation() async {
    // Lesson 153: Use a try/catch block to catch the error if location can't be acquired, see example below
    // Create an empty variable
    Position position;
    try {
      // Try to assign a value using the Geolocator
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // If it works, print the position
      // print(position);
      // Lesson 154: assign values to the variables
      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      // If it fails, print the error or a default String
      print(e);
    }
  }  
}


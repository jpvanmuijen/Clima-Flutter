import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  var weatherData;
  LocationScreen(this.weatherData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // Lesson 160: create variables to hold data
  String main;
  double temp;
  int temperature;
  int condition;
  String city;
  // Lesson 161: create weatherModel to receive icons and message
  // Lesson 162: use this object to re-initialize the location and weather (top left button)
  WeatherModel weather = WeatherModel();
  String icon;
  String message;

  @override
  void initState() {
    super.initState();
    // Lesson 160: Using the widget object, we get access to the stateful widget properties
    // print(widget.weatherData);
    updateUI(widget.weatherData);
  }

  // Lesson 160: create method to update UI with values from weatherData
  void updateUI(dynamic weatherData) {
    // Lesson 161: if new data is available, we should call SetState to rebuild the widget
    setState(() {
      // These variables can be set to specific types, depending on the JSON source
      // Lesson 158: data is fetched from the weatherdata object which is returned by the NetworkHelper/getData method
      main = weatherData['weather'][0]['main'];
      temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      city = weatherData['name'];
      print(
          'Sky: $main, Temp: $temperature, Condition: $condition, City: $city');
      // Lesson 161: Get icon and message from WeatherModel
      icon = weather.getWeatherIcon(condition);
      message = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      // Lesson 162: use the weatherData object to retrieve new location and weather, then call updateUIT
                      // We have to wait until getLocationWeather returns data, so we need async/await
                      // SetState is called in updateUI, so we don't need it here
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  // Lesson 161: display message and city
                  '$message in $city!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

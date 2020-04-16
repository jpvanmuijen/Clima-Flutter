import '../services/location.dart';
import '../services/networking.dart';

// Lesson 158: create variables on State level to store lat & lon
double latValue;
double lonValue;
const apiKey = '6d3a717320d3d4ded3be9c990f9d94a6';
const openWeathermapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  // The method should return a dynamic Future, i.e. weatherData after it got fetched
  Future<dynamic> getLocationWeather() async {
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
        '$openWeathermapURL?lat=$latValue&lon=$lonValue&appid=$apiKey&units=metric');

    // Lesson 158: get weatherData from NetworkHelper using its getData method
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

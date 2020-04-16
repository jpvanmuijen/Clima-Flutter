// Lesson 156: add as http to identify from which package the methods are called (below)
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  // Lesson 158: return a Future to wait for it to return the get response
  Future getData() async {
    // Lesson 157: use http prefix to identify the methods as coming from http.dart package
    http.Response response = await http.get(url);
    //  http://api.openweathermap.org/data/2.5/weather?lat=$latValue&lon=$lonValue&appid=$apiKey&units=metric
    if (response.statusCode == 200) {
      String data = response.body;
      // Lesson 157: decode JSON only once, output is dymanic, so the variable is dynamic
      var decodedData = jsonDecode(data);
      // Lesson 158: return the data to convert the Future to a String
      return decodedData;   
    } else {
      print(response.statusCode);
    }
  } 
}
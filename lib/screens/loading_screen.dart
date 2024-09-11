import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Get the location of the device as soon as the screen loads
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    print('Latitude: ${location.latitude}');
    print('Longitude: ${location.longitude}');
  }

  void getWeatherData() async {
    final uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={YOUR API KEY}");
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String weatherData = response.body;
      var decodedWeatherData = jsonDecode(
          weatherData); // Store the decoded data in one variable to avoid repetition

      var theTemperature = decodedWeatherData['main']['temp'];
      var theConditionNumber = decodedWeatherData['weather'][0]['id'];
      String cityName = decodedWeatherData['name'];

      // Print each of the pulled data to the screen
      print(theTemperature);
      print(theConditionNumber);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getWeatherData();
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            //Get the current location
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}

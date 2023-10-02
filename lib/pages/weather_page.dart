import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController locationController = TextEditingController();
  String apiKey = '623ee49b85f44368a0f11038bee140c0';
  String weatherData = '';

  Future<void> getWeatherData(String location) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String cityName = data['name'];
      final String temperature =
          (data['main']['temp'] - 273.15).toStringAsFixed(2);
      final String description = data['weather'][0]['description'];

      setState(() {
        weatherData =
            'City: $cityName\nTemperature: $temperature°C\nDescription: $description';
      });
    } else {
      setState(() {
        weatherData = 'Error: Unable to fetch weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Enter location',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                final location = locationController.text;
                if (location.isNotEmpty) {
                  getWeatherData(location);
                }
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 25),
            Text(
              weatherData,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

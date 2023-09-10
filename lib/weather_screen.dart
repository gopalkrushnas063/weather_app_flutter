import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wheather_app_flutter/addition_info_item.dart';
import 'package:wheather_app_flutter/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:wheather_app_flutter/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    String cityName = 'London';

    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherAPIKey'),
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF331866), // Define the first color
                Color(0xFF331866), // Define the second color
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 80, 64, 139), // Define the first color
              Color.fromARGB(255, 93, 44, 95), // Define the second color
            ], // Define your gradient colors
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color.fromARGB(255, 32, 5, 82),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300K',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Rain',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Weather Forecast',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              //weather forecast card
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecastItem(
                      time: '03:23',
                      temp: '398.9',
                      icon: Icons.cloud,
                    ),
                    HourlyForecastItem(
                      time: '09:23',
                      temp: '234.9',
                      icon: Icons.sunny,
                    ),
                    HourlyForecastItem(
                      time: '06:23',
                      temp: '215.9',
                      icon: Icons.sunny_snowing,
                    ),
                    HourlyForecastItem(
                      time: '05:23',
                      temp: '398.9',
                      icon: Icons.cloudy_snowing,
                    ),
                    HourlyForecastItem(
                      time: '03:23',
                      temp: '398.9',
                      icon: Icons.sunny_snowing,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              //additional information card
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(
                    icon: 'assets/images/humidity.png',
                    label: 'Humidity',
                    value: '91',
                  ),
                  AdditionalInfoItem(
                    icon: 'assets/images/wind.png',
                    label: 'Wind Speed',
                    value: '1000',
                  ),
                  AdditionalInfoItem(
                    icon: 'assets/images/rain.png',
                    label: 'Pressure',
                    value: '7.5',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

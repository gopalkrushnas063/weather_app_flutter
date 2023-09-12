import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Bhubaneswar';

      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(response.body);

      if (data['cod'] != '200') {
        throw 'An unexpexted error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontFamily: 'Overpass',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Text color
            shadows: [
              Shadow(
                color: Colors.black, // Shadow color
                offset: Offset(2, 3), // Shadow offset
                blurRadius: 20, // Shadow blur radius
              ),
            ],
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4A91FF), // Use the new color #47BFDF
                Color(0xFF47BFDF), // Define the first color
              ], // Define your gradient colors
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final data = snapshot.data!;
          final currenWeattherData = data['list'][0];

          final currentTemp = currenWeattherData['main']['temp'];
          final currentSky = currenWeattherData['weather'][0]['main'];
          final currentPresure = currenWeattherData['main']['pressure'];
          final currentHumidity = currenWeattherData['main']['humidity'];
          final currentWindSpeed = currenWeattherData['wind']['speed'];

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF47BFDF), // Define the first color
                  Color(0xFF4A91FF), // Use the new color #47BFDF
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
                      elevation: 10, // You can adjust the elevation as needed
                      margin: const EdgeInsets.all(16), // Add margin as needed
                      color: Colors
                          .transparent, // Set the card's color to transparent
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF4A91FF), // Starting color (#4A91FF)
                              Color(0xFF47BFDF), // Ending color (#47BFDF)
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp K , Bhubaneswar',
                                  style: const TextStyle(
                                    fontFamily: 'Overpass',
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Text color
                                    shadows: [
                                      Shadow(
                                        color: Colors.black, // Shadow color
                                        offset: Offset(3, 3), // Shadow offset
                                        blurRadius: 20, // Shadow blur radius
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Image.asset(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? 'assets/images/cloudy.png'
                                      : 'assets/images/sunny.png',
                                  width: 64,
                                  height: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  currentSky,
                                  style: const TextStyle(
                                    fontFamily: 'Overpass',
                                    fontSize: 20,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black, // Shadow color
                                        offset: Offset(3, 3), // Shadow offset
                                        blurRadius: 20, // Shadow blur radius
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black, // Shadow color
                            offset: Offset(3, 3), // Shadow offset
                            blurRadius: 20, // Shadow blur radius
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  //----------------------------
                  //weather forecast card
                  //----------------------------

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 39; i++)
                  //         HourlyForecastItem(
                  //           time: data['list'][i + 1]['dt'].toString(),
                  //           temp:
                  //               data['list'][i + 1]['main']['temp'].toString(),
                  //           icon: data['list'][i + 1]['weather'][0]['main'] == 'Clouds' || data['list'][i + 1]['weather'][0]['main'] == 'Rain'
                  //               ? Icons.cloud
                  //               : Icons.sunny,
                  //         ),
                  //     ],
                  //   ),
                  // ),

                  //----------------------------------------
                  // Using ListView.builder for lazy loading
                  //----------------------------------------
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlyIcon =
                            data['list'][index + 1]['weather'][0]['main'];

                        final time = DateTime.parse(hourlyForecast['dt_txt']);
                        return HourlyForecastItem(
                          time: DateFormat.Hm().format(time),
                          temp: hourlyForecast['main']['temp'].toString(),
                          icon: hourlyIcon == 'Clouds' || hourlyIcon == 'Rain'
                              ? 'assets/images/cloudy.png'
                              : 'assets/images/sunny.png',
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  //additional information card
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Additional Information',
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black, // Shadow color
                            offset: Offset(3, 3), // Shadow offset
                            blurRadius: 20, // Shadow blur radius
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: 'assets/images/humidity.png',
                        label: 'Humidity',
                        value: currentHumidity.toString(),
                      ),
                      AdditionalInfoItem(
                        icon: 'assets/images/wind.png',
                        label: 'Wind Speed',
                        value: currentWindSpeed.toString(),
                      ),
                      AdditionalInfoItem(
                        icon: 'assets/images/rain.png',
                        label: 'Pressure',
                        value: currentPresure.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

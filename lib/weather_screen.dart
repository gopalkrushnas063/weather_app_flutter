import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wheather_app_flutter/addition_info_item.dart';
import 'package:wheather_app_flutter/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300°F',
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
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1000',
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.5',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

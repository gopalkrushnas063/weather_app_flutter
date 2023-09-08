import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF59469D), // Define the first color
            Color(0xFF643D67), // Define the second color
          ], // Define your gradient colors
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        elevation: 6,
        color: Colors.transparent,
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                icon,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                temp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temp;
  final String icon;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.transparent,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white38, // Starting color (#4A91FF)
              Colors.white38, // Ending color (#47BFDF)
            ],
          ),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontFamily: 'Overpass',
                fontSize: 24,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Image.asset(
              icon,
              height: 32,
            ),
            const SizedBox(height: 8),
            Text(
              temp,
              style: const TextStyle(
                fontFamily: 'Overpass',
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
          ],
        ),
      ),
    );
  }
}

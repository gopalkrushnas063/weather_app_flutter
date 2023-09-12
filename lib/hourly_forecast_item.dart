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

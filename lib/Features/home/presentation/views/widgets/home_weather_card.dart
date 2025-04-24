import 'package:flutter/material.dart';
import 'package:mazraaty/Core/utils/styles.dart';

class HomeWeatherCard extends StatelessWidget {
  const HomeWeatherCard(
      {super.key,
      required this.temperature,
      required this.weatherCondition,
      required this.humidity,
      required this.uvIndex,
      required this.sunsetTime});
  final double temperature;
  final String weatherCondition;
  final String humidity;
  final String uvIndex;
  final String sunsetTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Deeper shadow
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
          // Subtle top shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
          // Inner light shadow for a softer edge
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weather',
                    style: Styles.textStyle20,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Perfect for plant care',
                    style: Styles.textStyle15,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.thermostat,
                        size: 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${temperature.round()}°C',
                        style: Styles.textStyle20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    weatherCondition,
                    style: Styles.textStyle15.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeatherMatrix(
                icon: Icons.water_drop,
                value: '$humidity%',
                label: 'Humidity',
                color: Colors.blue,
              ),
              _buildWeatherMatrix(
                icon: Icons.wb_sunny,
                value: uvIndex,
                label: 'UV Index',
                color: Colors.orange,
              ),
              // Sunset
              _buildWeatherMatrix(
                icon: Icons.access_time,
                value: sunsetTime,
                label: 'Sunset',
                color: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWeatherMatrix({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: Styles.textStyle18,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: Styles.textStyle13.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}

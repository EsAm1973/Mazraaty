class WeatherModel {
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String condition;
  final int humidity;
  final String uvIndex;
  final String sunset;
  final String cityName;
  final String feelsLike;

  WeatherModel({
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.humidity,
    required this.uvIndex,
    required this.sunset,
    required this.cityName,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // Get temperature values directly (already in Celsius when units=metric)
    final temp = json['main']['temp'].toDouble();
    final tempMin = json['main']['temp_min'].toDouble();
    final tempMax = json['main']['temp_max'].toDouble();
    final feelsLike = json['main']['feels_like'].toDouble();

    // Convert sunset timestamp to time string
    final sunset = DateTime.fromMillisecondsSinceEpoch(
      json['sys']['sunset'] * 1000,
      isUtc: true,
    ).toLocal();

    return WeatherModel(
      temperature: temp,
      tempMin: tempMin,
      tempMax: tempMax,
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      // Simplified UV Index based on time of day
      uvIndex: _calculateUVIndex(json['dt'] * 1000),
      sunset: '${sunset.hour}:${sunset.minute.toString().padLeft(2, '0')}',
      cityName: json['name'],
      feelsLike: '${feelsLike.round()}°C',
    );
  }

  static String _calculateUVIndex(int timestamp) {
    final hour = DateTime.fromMillisecondsSinceEpoch(timestamp).hour;
    if (hour >= 10 && hour <= 16) return 'High';
    if (hour >= 7 && hour <= 19) return 'Moderate';
    return 'Low';
  }
}
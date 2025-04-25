import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/utils/styles.dart';
import 'package:mazraaty/Features/home/presentation/manager/Weather%20Cubit/weather_cubit.dart';
import 'package:mazraaty/constants.dart';

class HomeWeatherCard extends StatefulWidget {
  const HomeWeatherCard({super.key});

  @override
  State<HomeWeatherCard> createState() => _HomeWeatherCardState();
}

class _HomeWeatherCardState extends State<HomeWeatherCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  // Temperature unit state
  bool _isCelsius = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Convert Celsius to Fahrenheit
  double _celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  // Format temperature based on selected unit
  String _formatTemperature(double celsius) {
    if (_isCelsius) {
      return celsius.round().toString();
    } else {
      return _celsiusToFahrenheit(celsius).round().toString();
    }
  }

  // Get temperature unit symbol
  String _getTemperatureUnit() {
    return _isCelsius ? '°C' : '°F';
  }

  // Toggle temperature unit
  void _toggleTemperatureUnit() {
    setState(() {
      _isCelsius = !_isCelsius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return _buildLoadingState();
        } else if (state is WeatherError) {
          return _buildErrorState(state.message);
        } else if (state is WeatherLoaded) {
          return _buildWeatherCard(state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: kMainColor,
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.cloud_off,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Weather data unavailable',
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Styles.textStyle15.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              context.read<WeatherCubit>().getWeather('Alexandria');
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(WeatherLoaded state) {
    // Determine background gradient based on weather condition
    List<Color> gradientColors = _getWeatherGradient(state.weather.condition);

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withAlpha(40),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Weather',
                              style: Styles.textStyle20.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(
                                Icons.my_location,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                context.read<WeatherCubit>().getWeather('Alexandria');
                              },
                            ),
                          ],
                        ),
                        Text(
                          state.weather.cityName,
                          style: Styles.textStyle16.copyWith(
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            _getWeatherIcon(state.weather.condition),
                            const SizedBox(width: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatTemperature(state.weather.temperature),
                                  style: Styles.textStyle30.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _toggleTemperatureUnit,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.white.withAlpha(120),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          _getTemperatureUnit(),
                                          style: Styles.textStyle16.copyWith(
                                            color: Colors.white.withAlpha(220),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        Icon(
                                          Icons.swap_horiz,
                                          size: 12,
                                          color: Colors.white.withAlpha(180),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              state.weather.condition,
                              style: Styles.textStyle16.copyWith(
                                color: Colors.white.withAlpha(220),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white.withAlpha(180),
                                  size: 12,
                                ),
                                Text(
                                  '${_formatTemperature(state.weather.tempMin)}°',
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(180),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white.withAlpha(180),
                                  size: 12,
                                ),
                                Text(
                                  '${_formatTemperature(state.weather.tempMax)}°',
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(180),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _isCelsius
                                ? 'Feels like ${state.weather.feelsLike}'
                                : 'Feels like ${_celsiusToFahrenheit(double.parse(state.weather.feelsLike.replaceAll('°C', ''))).round()}°F',
                              style: TextStyle(
                                color: Colors.white.withAlpha(180),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWeatherMatrix(
                        icon: Icons.water_drop,
                        value: '${state.weather.humidity}%',
                        label: 'Humidity',
                        color: Colors.white,
                      ),
                      _buildWeatherMatrix(
                        icon: Icons.wb_sunny,
                        value: state.weather.uvIndex,
                        label: 'UV Index',
                        color: Colors.white,
                      ),
                      _buildWeatherMatrix(
                        icon: Icons.access_time,
                        value: state.weather.sunset,
                        label: 'Sunset',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
        const SizedBox(height: 8),
        Text(
          value,
          style: Styles.textStyle18.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Styles.textStyle13.copyWith(
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _getWeatherIcon(String condition) {
    IconData iconData;
    double size = 36;

    condition = condition.toLowerCase();

    if (condition.contains('cloud') || condition.contains('overcast')) {
      iconData = Icons.cloud;
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      iconData = Icons.water_drop;
    } else if (condition.contains('snow') || condition.contains('sleet')) {
      iconData = Icons.ac_unit;
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      iconData = Icons.flash_on;
    } else if (condition.contains('fog') || condition.contains('mist')) {
      iconData = Icons.cloud;
    } else if (condition.contains('clear') || condition.contains('sun')) {
      iconData = Icons.wb_sunny;
    } else {
      iconData = Icons.wb_sunny_outlined;
    }

    return Icon(
      iconData,
      color: Colors.white,
      size: size,
    );
  }

  List<Color> _getWeatherGradient(String condition) {
    condition = condition.toLowerCase();

    if (condition.contains('cloud') || condition.contains('overcast')) {
      return [
        const Color(0xFF5D8CAE),
        const Color(0xFF7FA5C3),
      ];
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return [
        const Color(0xFF4A6D8C),
        const Color(0xFF6B8EAD),
      ];
    } else if (condition.contains('snow') || condition.contains('sleet')) {
      return [
        const Color(0xFF7B9EB7),
        const Color(0xFFA5C0D3),
      ];
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return [
        const Color(0xFF4A5D8C),
        const Color(0xFF6B7EAD),
      ];
    } else if (condition.contains('fog') || condition.contains('mist')) {
      return [
        const Color(0xFF8C9DA9),
        const Color(0xFFADBDC7),
      ];
    } else if (condition.contains('clear') || condition.contains('sun')) {
      return [
        const Color(0xFF4A90E2),
        const Color(0xFF5DADE2),
      ];
    } else {
      return [
        const Color(0xFF5D8CAE),
        const Color(0xFF7FA5C3),
      ];
    }
  }
}

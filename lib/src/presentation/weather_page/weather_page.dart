import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:daygraph/main.dart';
import 'package:daygraph/src/constants/app_colors.dart';
import 'package:daygraph/src/presentation/weather_page/city_search_box.dart';
import 'package:daygraph/src/presentation/weather_page/current_weather.dart';
import 'package:daygraph/src/presentation/weather_page/daily_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  Widget build(BuildContext context) {
    loggerNoStack.d('WeatherPage:build');
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Spacer(),
              CitySearchBox(),
              Spacer(),
              CurrentWeather(),
              Spacer(),
              DailyWeather(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

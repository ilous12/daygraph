import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daygraph/main.dart';
import 'package:daygraph/src/domain/entities/weather/weather_data.dart';
import 'package:daygraph/src/presentation/weather_page/city_search_box.dart';
import 'package:daygraph/src/presentation/weather_page/current_weather_controller.dart';
import 'package:daygraph/src/presentation/weather_page/weather_icon_image.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loggerNoStack.d('CurrentWeather:build');
    final weatherDataValue = ref.watch(currentWeatherControllerProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(city, style: Theme.of(context).textTheme.headline4),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => Column(
            children: const [
              SizedBox(height: 40),
              Center(child: CircularProgressIndicator()),
            ],
          ),
          error: (e, __) => Text(e.toString()),
        ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({Key? key, required this.data})
      : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loggerNoStack.d('CurrentWeatherContents:build');
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = '섭씨 최고:$maxTemp° 최저:$minTemp°';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 100),
        Column(
          children: [
            Text(temp, style: textTheme.headline2),
            Text(highAndLow, style: textTheme.bodyText2),
          ],
        )
      ],
    );
  }
}

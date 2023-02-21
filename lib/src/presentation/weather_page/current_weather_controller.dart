import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daygraph/main.dart';
import 'package:daygraph/src/domain/entities/weather/weather_data.dart';
import 'package:daygraph/src/presentation/weather_page/city_search_box.dart';
import 'package:daygraph/src/data/repositories/api_error.dart';
import 'package:daygraph/src/data/repositories/weather_repository.dart';

class CurrentWeatherController extends StateNotifier<AsyncValue<WeatherData>> {
  CurrentWeatherController(this._weatherRepository, {required this.city})
      : super(const AsyncValue.loading()) {
    getWeather(city: city);
  }

  final HttpWeatherRepository _weatherRepository;
  final String city;

  Future<void> getWeather({required String city}) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _weatherRepository.getWeather(city: city);
      state = AsyncValue.data(WeatherData.from(weather));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final currentWeatherControllerProvider = StateNotifierProvider.autoDispose<
    CurrentWeatherController, AsyncValue<WeatherData>>((ref) {
  loggerNoStack.d('weatherRepository watch before');
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  loggerNoStack.d('weatherRepository watch');
  final city = ref.watch(cityProvider);
  loggerNoStack.d('city watch');
  return CurrentWeatherController(weatherRepository, city: city);
});

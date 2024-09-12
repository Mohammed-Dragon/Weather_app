import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherServices {
  final Dio _dio = Dio();

  Future<Weather> getWeatherByLocation(
      double latitude, double longitude) async {
    final apiKey = '061f4ae21816cb051f29649756baa299';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }
}

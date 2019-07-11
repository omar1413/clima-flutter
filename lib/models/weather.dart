import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'dart:convert';

class Weather {
  String get city {
    return _city;
  }

  double get temp {
    return _temp;
  }

  String _city;
  double _temp;
  Location _location;
  int _deg;

  var _weatherData;

  Future<void> _getLocation() async {
    _location = Location();
    await _location.getLocation();
  }

  Future<Weather> fetchWeatherData() async {
    await _getLocation();
    NetworkHelper networkHelper = NetworkHelper();
    _weatherData = await networkHelper.getData(_location.lat, _location.long);

    setupWeatherData();

    return this;
  }

  Future<void> fetchWeatherDataByLocation(String city) async {
    NetworkHelper networkHelper = NetworkHelper();
    _weatherData = await networkHelper.getLocationData(city);

    setupWeatherData();
  }

  void setupWeatherData() {
    try {
      _temp = _weatherData['main']['temp'];
      _city = _weatherData['name'];
      _deg = _weatherData['wind']['deg'];
    } catch (e) {
      _temp = 0;
      _city = 'there is error';
      _deg = 0;
      print(e);
    }
  }

  String getWeatherIcon() {
    int condition = _deg;
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    int temp = _temp.toInt();
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

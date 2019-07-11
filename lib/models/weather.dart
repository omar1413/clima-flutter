import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'dart:convert';

class Weather {
  String _city;
  int _temp;
  Location _location;
  var _weatherData;

  Future<void> _getLocation() async {
    _location = Location();
    await _location.getLocation();
  }

  Future<Map<String, dynamic>> fetchWeatherData() async {
    await _getLocation();
    NetworkHelper networkHelper = NetworkHelper();
    var response = await networkHelper.getData(_location.lat, _location.long);
    _weatherData = jsonDecode(response);

    _temp = _weatherData['main']['temp'];
    _city = _weatherData['name'];

    return {'city': _city, 'temp': _temp};
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper();

  final String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String appId = '03ff3df15f8728dd423bb6518f34725c';

  Future _fetch(String url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getData(double lat, double long) async {
    return await _fetch(
        '$baseUrl/weather?lat=$lat&lon=$long&appid=$appId&units=metric');
  }

  Future getLocationData(String city) async {
    return await _fetch('$baseUrl/weather?q=$city&appid=$appId&units=metric');
  }
}

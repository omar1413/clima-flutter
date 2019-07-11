import 'package:flutter/material.dart';
import 'package:clima/models/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    Weather weather = Weather();
    Map<String, dynamic> data = await weather.fetchWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return LocationScreen(
        city: data['city'],
        temp: int.parse(data['temp']),
      );
    }));
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

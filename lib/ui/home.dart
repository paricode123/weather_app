import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:climate_app/Wigets/weather_item.dart';


class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Map<String, dynamic> _weatherData = {};
  List<Map<String, dynamic>> _forecastData = [];
  final _locationController = TextEditingController();
  bool _isCelsius = true;
  String imageUrl = '';
  String _userLocation = '';
  late String _sunrise = '';
  late String _sunset = '';

  Future<void> _fetchWeatherData(String location) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=788d705e1f04c702423f569746987ad4'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _weatherData = data;
        _sunrise = DateFormat('jm').format(
            DateTime.fromMillisecondsSinceEpoch(
                data['sys']['sunrise'] * 1000,
                isUtc: false));
        _sunset = DateFormat('jm').format(
            DateTime.fromMillisecondsSinceEpoch(
                data['sys']['sunset'] * 1000,
                isUtc: false));
      });
    } else {
      setState(() {
        _weatherData = {};
      });
    }
  }

  Future<void> _fetchForecastData(String location) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=788d705e1f04c702423f569746987ad4'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['list'];
      setState(() {
        _forecastData = List.generate(
          5,
              (index) => {
            'date': DateFormat('yyyy-MM-dd').format(
              DateTime.parse(data[index * 8]['dt_txt']),
            ),
            'high': data[index * 8]['main']['temp_max'].toDouble(),
            'low': data[index * 8]['main']['temp_min'].toDouble(),
            'description': data[index * 8]['weather'][0]['description'],
          },
        );
      });
    } else {
      setState(() {
        _forecastData = [];
      });
    }
  }

  String _getFormattedTemperature(double temperature) {
    if (_isCelsius) {
      return '${(temperature - 273.15).toStringAsFixed(1)} °C';
    } else {
      double fahrenheit = (temperature - 273.15) * 9 / 5 + 32;
      return '${fahrenheit.toStringAsFixed(1)} °F';
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchWeatherData('london');
  //   _fetchForecastData('london');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff90B2F9),
        title: Text('Weather Forecast'),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: 10,),
        Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Enter location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            FlatButton(
              onPressed: () {
                _fetchWeatherData(_locationController.text);
                _fetchForecastData(_locationController.text);
              },
              child: Text('Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ],
              ),
            ),
            _weatherData.isEmpty
                ? SizedBox.shrink()
                : Column(
                children: [
                  if (_weatherData.isNotEmpty)
                  SizedBox(height: 20,),
                Container(
                width: 370,
                height: 230,
                decoration: BoxDecoration(
                    color: Color(0xff90B2F9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff90B2F9).withOpacity(.5),
                        offset: const Offset(0, 25),
                        blurRadius: 10,
                        spreadRadius: -12,
                      )
                    ]),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (_weatherData.isNotEmpty)

                    Positioned(
                      top: 20,
                      left: 20,
                      child:Text(
                        '${_weatherData['name']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 20,
                      child:Text(
                        _weatherData['weather']?[0]['description']?.toUpperCase() ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://openweathermap.org/img/w/${_weatherData['weather'][0]['icon']}.png',
                            height: 64,
                            width: 64,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Text(
                            _getFormattedTemperature(_weatherData['main']['temp'].toDouble()),
                            style: TextStyle(fontSize: 48),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${_weatherData['main']['humidity']}% Humidity',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),)

                        ],
                      ),
                    ),

                  ],
                ),
            ),
                const SizedBox(height: 50,),
                Container(
                 padding: const EdgeInsets.symmetric(horizontal: 40),

                child:Column(
                  children: [
                    if (_weatherData.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        weatherItem(
                          text1:'Wind Speed',
                          imageUrl: 'assets/windspeed.png.png',
                          text:'${_weatherData?['wind']?['speed']?.toDouble().toStringAsFixed(1) ?? 0.0} km/h',
                        ),
                        weatherItem(
                          text1:'Max Temp',
                          imageUrl: 'assets/max.png.png',
                          text:'${_getFormattedTemperature(_forecastData[0]['high'])}',
                        ),
                        weatherItem(
                          text1:'Min Temp',
                          imageUrl: 'assets/humidity.png.png',
                          text:'${_getFormattedTemperature(_forecastData[0]['low'])}',
                        ),
                      ],
                    ),


                  ],
                ),

                ),
                const SizedBox(height: 50,),

                Text(
                'Next 5 Days',
                 style: TextStyle(
                 decoration: TextDecoration.underline,
                 fontWeight: FontWeight.w600,
                 fontSize: 18,
                 color: Color(0xff90B2F9),
                 ),
              ),
                ],          ),
               SizedBox(height: 20,),
              SingleChildScrollView(

                scrollDirection: Axis.horizontal,

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: (() {
                    List<Widget> widgets = [];
                    for (int i = 0; i < _forecastData.length; i++) {
                      widgets.add(
                        Container(

                          width: 140.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Color(0xff90B2F9),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                _forecastData[i]['date'],
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Text(
                                'Max: ${_getFormattedTemperature(_forecastData[i]['high'])}',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                'Min: ${_getFormattedTemperature(_forecastData[i]['low'])}',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                _forecastData[i]['description'],
                                style: TextStyle(fontSize: 16.0,
                                color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                      );
                      if (i < _forecastData.length - 1) {
                        widgets.add(SizedBox(width: 15.0));
                      }
                    }
                    return widgets;
                  })(),
                ),
              ),


            ],
      ),
      ),);
  }
}
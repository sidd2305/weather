import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd47b7b),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffd2de23),
          title: Text(
            "Weather App",
            style: TextStyle(fontStyle: FontStyle.normal, fontSize: 30),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1592210454359-9043f067919b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8d2VhdGhlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: apicall(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            '📍${snapshot.data['name'].toString()}',
                            style: TextStyle(
                              fontSize: 75,
                              color: Color(0xff3d3d3d),
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            snapshot.data['description'].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff6769d9),
                            ),
                          ),
                          SizedBox(height: 20),
                          Icon(
                            WeatherIcon.getIcon('wi-owm-day-200'),
                            color: Color(0xff2cb8db),
                            size: 70.0,
                          ),
                          SizedBox(height: 30),
                          Text(
                            '${snapshot.data['temp'].toString()}°C',
                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'min',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff2cb8db),
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data['temp_min'].toString()}°C',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff695151),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 4, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'max',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xffd9bfbf),
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data['temp_max'].toString()}°C',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xffdb648c),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Color(0xffd76969), //color of border
                                      width: 4, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Color(0xffd76969), //color of border
                                      width: 4, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'clouds',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff9e9cba),
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data['all'].toString()}',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff9e9cba),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ));
  }
}

var icon;
Future apicall() async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=11542823490b7fbc3699f1079ca374e0&units=metric");
  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json['weather'][0]['description']);
  // return json['weather'][0]['description'];

  final output = {
    'description': json['weather'][0]['description'],
    'temp': json['main']['temp'],
    'temp_min': json['main']['temp_min'],
    'temp_max': json['main']['temp_max'],
    'all': json['clouds']['all'],
    'icon': json['weather'][0]['icon'],
    'name': json['name'],
    'cod': json['cod'],
  };
  return output;
}

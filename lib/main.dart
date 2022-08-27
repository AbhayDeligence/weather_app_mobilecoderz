import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/views/screens/show_weather_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<WeatherProvider>(
      create: (context) => WeatherProvider(),
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
          textTheme: const TextTheme(
        headline1: TextStyle(color: Color.fromARGB(255, 249, 248, 250)),
        headline2: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        bodyText2: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      )),
      home: const ShowWeatherScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/service/featch_lat_long_service.dart';
import 'package:weather_app/views/screens/select_city_screen.dart';
import 'package:weather_app/views/widgets/calendar_widget.dart';

import '../widgets/week_weather.dart';

class ShowWeatherScreen extends StatefulWidget {
  const ShowWeatherScreen({Key? key}) : super(key: key);

  @override
  State<ShowWeatherScreen> createState() => _ShowWeatherScreenState();
}

class _ShowWeatherScreenState extends State<ShowWeatherScreen> {
  final locationService = FeatchLatLng();
  Position? position;

  Future getPosition() async {
    try {
        position = await locationService.determinePosition();
        
     
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    getPosition().then((value) {
      Provider.of<WeatherProvider>(context, listen: false).getWeatherbyLatlonHD(
          lat: position?.latitude ?? 0.0, lon: position?.longitude ?? 0.0);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (BuildContext context, WeatherProvider snapshot, _) {
            return Column(
              children: [
                Container(
                  height: size.height / 2.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.cyan[300]!.withOpacity(0.2),
                          spreadRadius: 8.2,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        tileMode: TileMode.repeated,
                        colors: [
                          Colors.cyan.withOpacity(0.7),
                          const Color.fromARGB(255, 44, 236, 216)
                              .withOpacity(0.3),
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Weather',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectCityScreen()));
                              },
                              child: SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Text(
                                        snapshot.weather?.timezone ??
                                            "City Name",
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 17),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_right_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.weather?.daily?.first.temp?.max
                                            .toString() ??
                                        "Null",
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 7),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.wb_sunny_sharp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        snapshot.weather?.daily?.first.weather
                                                ?.first.main ??
                                            "Null",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const CalendarWidget()
                          ],
                        ),
                        const SizedBox(height: 30),
                        WeatherRowWidget(
                          snapshot: snapshot,
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    '''To change city tap on "city name" text''',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

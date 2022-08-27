import 'package:flutter/material.dart';
import 'package:weather_app/provider/weather_provider.dart';

class WeatherRowWidget extends StatelessWidget {
  final WeatherProvider? snapshot;
  const WeatherRowWidget({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemCount: 7, //snapshot.data!.daily!.length,
        itemBuilder: (_, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_outlined,
                size: 40,
                color: Colors.white,
              ),
              Text(
                snapshot?.weather?.daily?[index].weather?.first.main ?? "Null",
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                snapshot?.weather?.daily?[index].temp?.max.toString() ?? "Null",
                style: const TextStyle(fontSize: 15),
              ),
            ],
          );
        },
      ),
    );
  }
}

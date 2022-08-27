import 'package:flutter/material.dart';
import 'package:weather_app/provider/weather_provider.dart';

class SelectCityWidget extends StatelessWidget {
  final WeatherProvider? snap;
  final ScrollController? scrollController;
  const SelectCityWidget({Key? key, this.snap, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        itemCount: snap!.record.length,
        itemBuilder: (context, int index) {
          return ListTile(
              onTap: () {
                snap!
                    .getWeatherbyLatlonHD(
                        lon: snap!.record[index].coord?.lon,
                        lat: snap!.record[index].coord?.lat)
                    .then((value) {
                  Navigator.pop(context);
                });
              },
              title: Text(snap!.record[index].name ?? "Null"),
              subtitle: Text('Country : ${snap!.record[index].country}'));
        });
  }
}

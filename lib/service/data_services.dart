import 'dart:convert';

import 'package:weather_app/model/city_list_model.dart';
import 'package:weather_app/model/weathers_model.dart';
import 'package:weather_app/utils/constant.dart';
import 'package:http/http.dart' as http;

class DataServices {
  Future<Weather> getWeatherbyLatlon({double? lat, double? lng}) async {
    final reqUrl =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&units=metric&appid=$wheatherAppId&exclude=current,minutely,hourly,alerts";

    final response = await http.get(Uri.parse(reqUrl));

    if (response.statusCode != 200) {
      throw Exception('Error Retreving Weather Details');
    }
    return Weather.fromJson(jsonDecode(response.body));
  }

  Future<CityNames> getCityWeather({String? cityname, int? pageNo}) async {
    final reqUrl =
        "http://52.73.146.184:3000/api/app/user/get-city-list?page=$pageNo&search=$cityname";
    final response = await http.get(Uri.parse(reqUrl));
    if (response.statusCode != 200) {
      throw Exception('Error Retreving Weather Details');
    }
    return CityNames.fromJson(jsonDecode(response.body));
  }
}

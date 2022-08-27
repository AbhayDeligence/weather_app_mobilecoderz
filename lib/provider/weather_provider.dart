import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/city_list_model.dart';
import 'package:weather_app/model/weathers_model.dart';
import 'package:weather_app/service/data_services.dart';

class WeatherProvider extends ChangeNotifier {
  final dataServices = DataServices();
  CityNames? cityNames;
  Weather? weather;
  List<Record> record = [];
  var pageNo = 0;


  Future getWeatherbyLatlonHD({double? lat, double? lon}) async {
    weather = await dataServices.getWeatherbyLatlon(lat: lat, lng: lon);
    notifyListeners();
  }

  Future getCityWeatherHD({String? city}) async {
    
    pageNo++;
    print(pageNo);
    cityNames =
        await dataServices.getCityWeather(cityname: city, pageNo: pageNo);
    List<Record>? r = cityNames?.data?.record?.toList();
    record.addAll(r!);
  

    notifyListeners();
  }
}

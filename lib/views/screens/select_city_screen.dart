import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/views/widgets/select_city_widget.dart';

class SelectCityScreen extends StatefulWidget {
  const SelectCityScreen({Key? key}) : super(key: key);

  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollcontroller = ScrollController();

  @override
  void initState() {
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.offset) {
        Provider.of<WeatherProvider>(context, listen: false)
            .getCityWeatherHD(city: controller.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 234, 244),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 220, 234, 244),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Change City',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Select City',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 5),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            OutlinedButton(
                onPressed: () {
                  provider.pageNo = 0;
                  provider.getCityWeatherHD(
                    city: controller.text,
                  );
                  provider.record.clear();
                },
                child: const Text('Search')),
            Expanded(
              child: Consumer<WeatherProvider>(builder: (context, snap, _) {
                return SelectCityWidget(
                  scrollController: scrollcontroller,
                  snap: snap,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

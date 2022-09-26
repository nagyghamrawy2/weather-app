import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather2/models.dart';

class DataService {
  Future <WeatherResponse> getWeather(String city)async{
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    final queryParameters = {
      'q' : city,
      'appid': '361d6ed764a982ebb3cda810bed96877',
      'units' : 'imperial'
    };
    final uri = Uri.http(
        'api.openweathermap.org', '/data/2.5/weather' , queryParameters);
    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);

  }

  Future<WeatherResponse>  fetchDataByLocation(var lon,var lat)async{
    try {
      http.Response response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=55dde77b227ed2d1acd42dfb037234c9'));

      // final queryParameters = {
      //     'lat' : lat,
      //     'lon' : lon,
      //     'appid': '361d6ed764a982ebb3cda810bed96877',
      //   };
      //   final uri = Uri.http(
      //       'api.openweathermap.org', '/data/2.5/weather' , queryParameters);
      //   final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = response.body;

        var jsonData = jsonDecode(data);
        WeatherResponse weather = WeatherResponse.fromJson(jsonData);

        return weather;
      } else
        print('${response.statusCode}');

    } catch (ex) {
      print(ex);
    }



  }
}
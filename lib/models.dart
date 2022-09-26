/*

{
"coord": {
       "lon": -0.13,
       "lat": 51.51
     },
  "weather": [
    {
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55,
  },
  "name": "Mountain View",
}


*/
class WeatherInfo {
  final String description;
  final String icon;
  WeatherInfo({ this.description ,  this.icon});
  factory  WeatherInfo.fromJson(Map<String ,dynamic> json ){
    final description = json ['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo{
  final double temprature ;
  TemperatureInfo({ this.temprature});
  factory  TemperatureInfo.fromJson(Map<String ,dynamic> json ){
    final temprature = json['temp'];
    return TemperatureInfo(temprature: temprature);
  }
}


class WeatherResponse{
   final String cityName;
   final TemperatureInfo tempInfo;
   final WeatherInfo weatherInfo;
   String get iconUrl {
     //dynamic Icon to show
     return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
   }

  WeatherResponse(this.tempInfo, this.weatherInfo, { this.cityName});
  //factory constructor is you will build customconstructor that you will pass data in
  factory WeatherResponse.fromJson(Map<String ,dynamic> json ){
    final cityName = json ['name'];
    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);
    final weatherInfojson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfojson);

    return WeatherResponse(tempInfo, weatherInfo, cityName: cityName);
  }


}
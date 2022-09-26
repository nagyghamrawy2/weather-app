import 'package:flutter/cupertino.dart';

import 'models.dart';

class Providers extends ChangeNotifier{
  bool check=false ;
  int num=0;
  get n=>num;
  WeatherResponse Responses;
  change(){check=!check;
  notifyListeners();}

changeToCity(){num=1;
  notifyListeners();}

  changeToLoc(){num=2;
  notifyListeners();}


  setWeather(WeatherResponse W){

    Responses=W;
    notifyListeners();

  }

}
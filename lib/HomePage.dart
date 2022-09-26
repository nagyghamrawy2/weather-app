



import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather2/DataService.dart';
import 'package:weather2/SecondPage.dart';
import 'package:weather2/models.dart';

class HomePage extends StatefulWidget {
  String city='';
  Future<WeatherResponse> r;
  HomePage({this.city,this.r}){}
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _cityTextController = new TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;
  Location location = new Location();
  bool isServiceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;
  bool isListenLocation = false , isGetLocation = false;
  double temp =0.0;
  String city ="";
  double log = 0.0;
  double lat =0.0;
  bool check =false;
  bool tempchange =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image:AssetImage('assets/images/3.jpeg'),
                fit: BoxFit.cover
            ),
          ),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    yy();
                    setState(() {
                      widget.r=null;
                    });
                  },
                    icon: Icon(Icons.location_on_sharp),iconSize: 50,),
                  IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SecondPage(),
                    ));
                  }, icon: Icon(Icons.location_city), iconSize: 50,)
                ],
              ),
              if(widget.r!=null)
                FutureBuilder(
                    future: widget.r,
                    builder: (BuildContext context,
                        AsyncSnapshot<WeatherResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Column(
                          children: [ Image.network(snapshot.data.iconUrl,scale: 0.5,),
                            Text("${((((snapshot.data.tempInfo.temprature) - 32)*5)/9)
                                .toInt()}°", style: TextStyle(fontSize: 60,color: Colors.white)),
                            Text(snapshot.data.weatherInfo.description, style: TextStyle(fontSize: 30,color: Colors.white)),
                            //Text("its${snapshot.data.weatherInfo.description} in ${snapshot.data.cityName}", style: TextStyle(fontSize: 30,color: Colors.white)),
                          ],);
                      }else {
                        return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),));
                      }}),

              if(_response != null && tempchange ==true )
                Column(
                    children: [
                      Image.network(_response.iconUrl ,scale: 0.5,),
                      Text("${((_response.tempInfo.temprature)-273).toInt()}°" , style: TextStyle(fontSize: 60,color: Colors.white),),
                      Text(_response.weatherInfo.description, style: TextStyle(fontSize: 30,color: Colors.white)),
                    ]
                ),

            ],
          ),

        ),
      ),
    );
  }
  Future<WeatherResponse> search()async{
    tempchange = false;
    final response = await _dataService.getWeather(widget.city);
    setState(() => _response = response);
    return response as WeatherResponse;
  }
  Future<WeatherResponse> yy()async{
    tempchange =true;
    final response = await _dataService.fetchDataByLocation(log ,lat);
    setState(() => _response = response);
    return response as WeatherResponse;
  }
}

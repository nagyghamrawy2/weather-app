import 'package:flutter/material.dart';
import 'package:weather2/HomePage.dart';
import 'package:weather2/models.dart';
import 'package:provider/provider.dart';
import 'Providers.dart';
import 'DataService.dart';

class SecondPage extends StatefulWidget {


  @override
  _SecondPageState createState() => _SecondPageState();

}

class _SecondPageState extends State<SecondPage> {
  TextEditingController _cityTextController = new TextEditingController();
  WeatherResponse _response;
  bool tempchange =false;
  final _dataService = DataService();
  Future<WeatherResponse>  w;
  @override
  Widget build(BuildContext context) {

  return Scaffold(
        body: Container(
          decoration: BoxDecoration(

            image: DecorationImage(
                image:AssetImage('assets/images/1.jpeg'),
                fit: BoxFit.cover
            ),
          ),
          child: SafeArea(
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back_ios) ,iconSize: 50,
                ),

                  Row(
                    children: [
                      IconButton(onPressed: (){},
                          icon: Icon(Icons.location_city_outlined), iconSize: 50,color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: SizedBox(
                          width: 280,
                          child: TextField(
                            controller: _cityTextController,
                            decoration: InputDecoration(
                              fillColor:Colors.white,
                                filled: true,
                                labelText: "Enter City Name",
                              labelStyle: TextStyle(
                                fontSize: 15 , color: Colors.grey
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(18.0)
                              )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                InkWell(
                  onTap: (){ setState(() {w=search();

                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>HomePage(city: _cityTextController.text.toString(),r: w ,)));
                      
                  });
                      },

                    child: Center(
                        child: Text(
                          "Get Weather" , style: TextStyle(fontSize: 50 ,fontWeight: FontWeight.bold , color: Colors.black),))),
              ],
            ),
          ),
        ),
    );
  } Future<WeatherResponse> search()async{
    tempchange = false;
    final response = await _dataService.getWeather(_cityTextController.text.toString());
    setState(() => _response = response);
    return response as WeatherResponse;
  }}

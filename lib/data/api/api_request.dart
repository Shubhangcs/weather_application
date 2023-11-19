import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/data/models/weather_model.dart';


class ApiRequest{

 static Future<WheatherDataModel> requestWeatherData(data) async {
   final request = await http.get(Uri.parse('http://api.weatherstack.com/current?access_key=52dcd309762d5fec86084e1487a6146b&query=${data.latitude.toString()},${data.longitude.toString()}'));
   final response = jsonDecode(request.body);
   print(response);
   final dartModel = WheatherDataModel.fromJson(response);
    return dartModel;
  }

}
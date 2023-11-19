class WheatherDataModel{
  final String country;
  final String location;
  final int temprature;
  final int weatherCode;
  final String windDirection;
  final int windSpeed;
  final String isDay;
  final String weatherDiscription;
  WheatherDataModel.fromJson(Map<String,dynamic> json):
    country = json['location']['country'],
    location = json['location']['name'],
    weatherDiscription = json['current']['weather_descriptions'][0],
    temprature = json['current']['temperature'],
    weatherCode = json['current']['weather_code'],
    windDirection = json['current']['wind_dir'],
    windSpeed = json['current']['wind_speed'],
    isDay = json['current']['is_day'];
}
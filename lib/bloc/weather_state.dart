part of 'weather_bloc.dart';


sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}


final class WeatherFetchSuccessState extends WeatherState{
  WheatherDataModel data;
  String imageLink;
  WeatherFetchSuccessState({required this.data , required this.imageLink});
}


final class WeatherExceptionState extends WeatherState{
  String errorMessage;
  WeatherExceptionState({required this.errorMessage});
}

final class WeatherLoadingState extends WeatherState{}
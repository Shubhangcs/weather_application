import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:weather/data/api/api_request.dart';
import 'package:weather/data/api/permission.dart';
import 'package:weather/data/models/weather_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherFetchEvent>((event, emit)async{
     try {
      emit(WeatherLoadingState());
       final dynamic position = await Location.determinePosition();
      final response = await ApiRequest.requestWeatherData(position);
      if(response.weatherCode == 395 || response.weatherCode == 392 || response.weatherCode == 389 || response.weatherCode == 386 || response.weatherCode == 200){
        emit(WeatherFetchSuccessState(data: response, imageLink: 'assets/1.png'));
      }else if(response.weatherCode == 377 || response.weatherCode == 374 || response.weatherCode == 371 || response.weatherCode == 368 || response.weatherCode == 365 || response.weatherCode == 362 || response.weatherCode == 350 || response.weatherCode == 338 || response.weatherCode == 335 || response.weatherCode == 332 || response.weatherCode == 329 || response.weatherCode == 326 || response.weatherCode == 323 || response.weatherCode == 320 || response.weatherCode == 317 || response.weatherCode == 227 || response.weatherCode == 182 || response.weatherCode == 179){
        emit(WeatherFetchSuccessState(data: response, imageLink: 'assets/4.png'));
      }else if(response.weatherCode == 359 || response.weatherCode == 356 || response.weatherCode == 353 || response.weatherCode == 314 || response.weatherCode == 311 || response.weatherCode == 308 || response.weatherCode == 305 || response.weatherCode == 302 || response.weatherCode == 299 || response.weatherCode == 296 || response.weatherCode == 293 || response.weatherCode == 176){
        emit(WeatherFetchSuccessState(data: response, imageLink: 'assets/2.png'));
      }else if(response.weatherCode == 284 || response.weatherCode == 281 || response.weatherCode == 266 || response.weatherCode == 263 || response.weatherCode == 260 || response.weatherCode == 248 || response.weatherCode == 230 || response.weatherCode == 185 || response.weatherCode == 143){
        emit(WeatherFetchSuccessState(data: response, imageLink: 'assets/5.png'));
      }else if(response.weatherCode == 119 || response.weatherCode == 116){
          emit(WeatherFetchSuccessState(data: response, imageLink: 'assets/8.png'));
      }else if(response.weatherCode == 113){
        if(response.isDay == "no"){
         emit( WeatherFetchSuccessState(data: response, imageLink: 'assets/12.png'));
        }else{
          emit( WeatherFetchSuccessState(data: response, imageLink: 'assets/6.png'));
        }
      }
      else{
        emit( WeatherFetchSuccessState(data: response, imageLink: 'assets/9.png'));
      }
     } catch (e) {
       emit(WeatherExceptionState(errorMessage: "Something Went Wrong"));
     }
    });
  }
}

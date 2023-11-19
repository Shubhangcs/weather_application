import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/data/api/permission.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/weather_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(
      WeatherFetchEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(1, -0.1),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(150)),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-1, -0.1),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(150)),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1),
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 131, 0),
                  borderRadius: BorderRadius.circular(0)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if(state is WeatherLoadingState){
                    return loadingScene();
                  }
                  else if(state is WeatherFetchSuccessState){
                    return mainScreen(state.data , state.imageLink);
                  }
                  else{
                    return errorScene();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainScreen(WheatherDataModel data , String imageLink) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child:  Text(
                data.country,
                style:const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
        const SizedBox(height: 10,),
            Align(
              alignment: const AlignmentDirectional(-1, 0),
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                child:  Text(
                  data.location,
                  style:const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Image.asset(imageLink , width: 350,),
            Text(data.weatherDiscription , style: const TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/9.png' , width: 100,),
                Text('${data.windSpeed}km/h', style:const TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),),
                Image.asset('assets/13.png' , width: 100,),
                Text('${data.temprature}℃', style:const TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),),
              ],
            ),
          const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions , size: 80, color: Colors.white,),
                const SizedBox(width: 10,),
                Text(data.windDirection, style:const TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),),
              ],
            ),
              const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
  Widget loadingScene(){
    return Center(
      child: LottieBuilder.asset('assets/Animation - 1700410363058.json' , width: 150,),
    );
  }

  Widget errorScene(){
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded , size: 80, color: Colors.white,),
          const SizedBox(height: 5,),
          const Text("Something Went Wrong" , style: TextStyle(color: Colors.white , fontSize: 22),),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            BlocProvider.of<WeatherBloc>(context).add(
              WeatherFetchEvent(),
            );
          }, child:const Text('Retry')),
        ],
      ),
    );
  }
}

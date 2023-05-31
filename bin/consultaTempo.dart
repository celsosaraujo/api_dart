import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart' as intl;
import "package:http/http.dart" as http;
import 'package:dio/dio.dart' as dio;

Future<void> main() async {

  // var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=-22.2138900&lon=-49.9458300&appid=684092e38c36b56bb340fdd83d8c6bd9");
  var url = Uri(
    scheme: 'https',
    host: 'api.openweathermap.org',
    path: 'data/2.5/weather',
    queryParameters: {
      'lat':"-22.2138900",
      'lon':"-49.9458300",
      'appid':"684092e38c36b56bb340fdd83d8c6bd9"
      }
  );

  // var response = await http.get(url);

  // var data = jsonDecode(response.body);
  var dio = Dio();
  var response = await dio.get(url.toString());

  // print("Temperatura ${ kelvinToCelsius( data["main"]["temp"] )}°C "
  //       "em ${data["name"]} " 
  //       "consultado no dia ${ timestampUnixToDataHora( data["dt"]}"
  //      );
  print("Temperatura ${ kelvinToCelsius( response.data["main"]["temp"] )}°C "
        "em ${response.data["name"]} " 
        "consultado no dia ${ timestampUnixToDataHora( response.data["dt"])}"
       );
  
}

String kelvinToCelsius(double tempKelvin){
  double tempCelsius = tempKelvin - 273.15;
  return tempCelsius.toStringAsPrecision(4);  
}

String timestampUnixToDataHora( int timestamp) {

  DateTime data = DateTime.
                    fromMillisecondsSinceEpoch(
                            timestamp * 1000, isUtc: true
                            );
  final formatoSaida = intl.DateFormat("dd/MM/yyyy HH:mm"); 
  DateTime dataLocal = data.toLocal();
  return formatoSaida.format(dataLocal);

}
import 'package:intl/intl.dart' as intl;
import 'package:dio/dio.dart';

void main() async {
  
  //https://openweathermap.org/
  //Endpoint = 'https://api.openweathermap.org/data/2.5/weather?lat=-22.2138900&lon=-49.9458300&lang=pt_br&appid=684092e38c36b56bb340fdd83d8c6bd9&units=metric';
  final apiKey = '684092e38c36b56bb340fdd83d8c6bd9';
  final latitude = '-22.2138900';
  final longitude = '-49.9458300';
  final uri = Uri(
    scheme: 'https',
    host: 'api.openweathermap.org',
    path: '/data/2.5/weather',
    queryParameters: {
      'lat': latitude,
      'lon': longitude,
      'lang': 'pt_br',
      'appid': apiKey,
      //'units': 'metric'     
    },
  );

  final dio = Dio();  
  final response = await dio.get(uri.toString());

  if (response.statusCode == 200) {
    // print("Temperatura de ${ kelvinToCelsius( response.data["main"]["temp"] ) } °C " 
    // Se informar o parâmetro 'units': 'metric', a API retorna a temperatura em Celsius
    // Portanto, não precisa converter.
    // No campo icon "weather":[{"id":800,"main":"Clear","description":"céu limpo","icon":"01n"}]
    // demonstra o ícone que pode ser consultado em https://openweathermap.org/weather-conditions
    print("Temperatura de ${ kelvinToCelsius( response.data["main"]["temp"] ) } °C " 
          "em ${response.data["name"]} "
          "no dia ${timestampUnixToDataHora(response.data["dt"])}");    
  } else {
    print('Erro ao fazer requisição: ${response.statusCode}');
  }

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
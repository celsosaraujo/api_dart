import 'package:dio/dio.dart';

void main() async {
  
  //https://openweathermap.org/
  //Endpoint = 'https://api.openweathermap.org/data/2.5/weather?lat=-22.2138900&lon=-49.9458300&appid=684092e38c36b56bb340fdd83d8c6bd9';
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
      'appid': apiKey,
    },
  );

  final dio = Dio();  
  final response = await dio.get(uri.toString());

  if (response.statusCode == 200) {
    print(response.data);
  } else {
    print('Erro ao fazer requisição: ${response.statusCode}');
  }
}

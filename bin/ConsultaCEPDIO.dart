import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final response = await dio.get('https://viacep.com.br/ws/17515440/json/');

  if (response.statusCode == 200) {
    final data = response.data;
    print(data['logradouro']);
  } else {
    print('Erro ao fazer requisição: ${response.statusCode}');
  }
}
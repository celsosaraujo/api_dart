import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
      .then((response) {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data[1]);
    } else {
      print('Erro ao fazer requisição: ${response.statusCode}');
    }
  });
}
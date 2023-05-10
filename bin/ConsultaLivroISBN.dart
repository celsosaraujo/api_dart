import 'package:http/http.dart' as http;

void main() async {
  final isbn = 'urn:isbn:9780140328721';
  final url = Uri.parse('https://openlibrary.org/api/books?bibkeys=$isbn&format=json&jscmd=data');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Erro ao fazer requisição: ${response.statusCode}');
  }
}

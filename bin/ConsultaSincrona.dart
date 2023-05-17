import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
      .then((response) {
    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      print("Usuário: ${data[0]['userId']}");

      for (int i = 0; i < data.length; i++) {        
        print("${i+1}º ITEM");
        print("\tCódigo: ${data[i]['id']}");
        print("\tTítulo: ${data[i]['title']}");
        print("\tCorpo: ${data[i]['body']}");        
      }     


      print("<------------------- OUTRO JEITO -------------------->");
      for(final item in data){             
        print("Código: ${item['id']}");
        print("\tTítulo: ${item['title']}");
        print("\tCorpo: ${item['body']}");
      }

    } else {
      print('Erro ao fazer requisição: ${response.statusCode}');
    }
  });
}

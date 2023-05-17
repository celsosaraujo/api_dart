import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final isbn = '9780140328721';
  final url = Uri.parse(
      'https://openlibrary.org/api/books?bibkeys=$isbn&format=json&jscmd=data');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);
    printData(jsonMap);
  }
}

void printData(dynamic data, {String chave = '',int depth = 0}) {
  if (data is Map) {
    data.forEach((key, value) {
      printTab(depth) ;      
      printData(value, chave: key, depth: depth);
    });
  } else if (data is List) {
    print(chave); 
    data.forEach((value) {     
      printTab(depth);         
      printData(value, depth: depth + 1);
    });
  } else {
    printTab(depth);
    print("$chave: $data");
  }
}

void printTab(int depth) {
  for (var i = 0; i < depth; i++) {
    stdout.write('\t');
  }
}
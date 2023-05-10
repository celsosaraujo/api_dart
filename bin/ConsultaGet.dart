import 'package:http/http.dart' as http;

Future<void> main() async {
  var url = Uri.parse('https://api.github.com/users/octocat');
  var response = await http.get(url);
  print(response.body);
}
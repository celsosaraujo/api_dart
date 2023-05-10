import 'dart:async';
import 'package:http/http.dart' as http;

Future<void> main() async {
  var url = Uri.parse('https://api.github.com/users/octocat');
  var request = http.Request('GET', url);
  request.headers['User-Agent'] = 'my-app';
  var response = await request.send();
  print(await response.stream.bytesToString());
}
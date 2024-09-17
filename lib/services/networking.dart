import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String weatherData = response.body;
      return jsonDecode(
          weatherData); // Store the decoded data in one variable to avoid repetition
    } else {
      print(response.statusCode);
    }
  }
}

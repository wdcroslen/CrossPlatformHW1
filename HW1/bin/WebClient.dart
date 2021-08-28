import 'package:http/http.dart' as http;
import 'dart:convert';

/// Class the interacts with the server
class WebClient {
  /// Returns the json response from a server
  Future getResponse(var url) async {
    // print('Obtaining Server Information...');
    var response;
    if (url == null) {
      print("Oh NO!");
    } else {
      response = await http.get(url);
    }
    response = parseJson(response.body);
    return response;
  }

  dynamic parseJson(var response) {
    return json.decode(response);
  }
}

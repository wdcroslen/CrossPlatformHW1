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

  /// Calls the url to play the game with a specific move
  // Future playGame(url, move, pid) async {
  //   var gameURL = url + '/play/?pid=$pid&move=$move';
  //   print('GAME URL: $gameURL\n');
  //   var json = await getResponse(gameURL, gameURL);
  //   print('MOVE RESPONSE: $json\n');
  //   return json; //returns move response to check if the game is over
  // }

  dynamic parseJson(var response) {
    return json.decode(response);
  }
}

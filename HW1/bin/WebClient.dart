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

  String getQuiz(var userChoice, var webService) {
    if (userChoice < 10) {
      webService = webService + '?quiz=quiz0' + userChoice.toString();
    } else {
      webService = webService + '?quiz=quiz' + userChoice.toString();
    }
    return webService;
  }

  // String generatePracticeQuiz {
  // Return a response but just alter the question list
  //   // Get random questions by going through x different quizzes and choosing a random question e.x: (rand(lengthOfQuestions))
  // }

  dynamic parseJson(var response) {
    return json.decode(response);
  }
}

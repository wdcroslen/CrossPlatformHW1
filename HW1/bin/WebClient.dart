import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

/// Class the interacts with the server
class WebClient {
  /// Returns the json response from a server
  Future getResponse(var url) async {
    // print('Obtaining Server Information...');
    var response;
    if (url == null) {
      print("Oh NO your url isn't right!!");
    } else {
      response = await http.get(url);
    }
    response = parseJson(response.body);
    return response;
  }

  Future getQuestion(var url) async {
    // print('Obtaining Server Information...');
    var response;
    if (url == null) {
      print("Oh NO!");
    } else {
      response = await http.get(url);
    }
    response = parseJson(response.body);
    // print(response);
    var rand = Random();
    var quizLength = response['quiz']['question'].length;
    var randomQuestion = rand.nextInt(quizLength);
    var question = response['quiz']['question'][randomQuestion];
    return question;
  }

  String getQuiz(var userChoice, var webService) {
    if (userChoice < 10) {
      webService = webService + '?quiz=quiz0' + userChoice.toString();
    } else {
      webService = webService + '?quiz=quiz' + userChoice.toString();
    }
    return webService;
  }

  Future generatePracticeQuiz(var quizLength, var webService) async {
    // Return a response but just alter the question list
    // need a set to ignore repeating random questions
    // might need to consider doing 2 questions from a given quiz depending on how long the response takes
    var randomURLs = [];
    var rand = Random();
    webService = webService + '?quiz=quiz0';
    for (var i = 0; i < quizLength; i++) {
      randomURLs.add(webService + (rand.nextInt(3) + 1).toString());
    }
    print(randomURLs);
    var response = await getResponse(Uri.parse((randomURLs[0])));
    var question = response['quiz']['question'];
    var q = question[rand.nextInt(question.length)];
    question = [];
    question.add(q);

    for (var i = 1; i < randomURLs.length; i++) {
      var tempQuestion = await getQuestion(Uri.parse(randomURLs[i]));
      question.add(tempQuestion);
    }

    response['quiz']['question'] = question;

    return response;
    // Get random questions by going through x different quizzes and choosing a random question e.x: (rand(lengthOfQuestions))
  }

  dynamic parseJson(var response) {
    return json.decode(response);
  }
}

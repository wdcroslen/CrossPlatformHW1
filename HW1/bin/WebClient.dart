import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'FillInQuestion.dart';
import 'MultipleChoiceQuestion.dart';

/// Class that interacts with the server
class WebClient {
  /// Returns the json response from a server
  Future getResponse(var url) async {
    var response;
    if (url == null) {
      print("Oh NO your url isn't right!!");
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

  /// Returns list of questions from random urls based on user-specified length.
  Future generatePracticeQuiz(var quizLength, var webService) async {
    var randomURLs = [];
    var rand = Random();
    var questionList = [];
    webService = webService + '?quiz=quiz0';
    for (var i = 0; i < quizLength; i++) {
      randomURLs.add(webService + (rand.nextInt(3) + 1).toString());
    }

    print(randomURLs);

    for (var i = 0; i < randomURLs.length; i++) {
      var response = await getResponse(Uri.parse(randomURLs[i]));
      var questionResponse = response['quiz']['question'];
      var questionJSON =
          questionResponse[rand.nextInt(questionResponse.length)];

      var type = questionJSON['type'];
      var question = (type == 1)
          ? MultipleChoiceQuestion.option(
              response['quiz']['question'][i]['option'])
          : FillInQuestion();
      question.setStem(response['quiz']['question'][i]['stem']);
      question.setAnswer(response['quiz']['question'][i]['answer'].toString());

      questionList.add(question);
    }

    return questionList;
  }

  /// returns a list of question objects based on the url of the quiz
  Future generateQuiz(var response) async {
    var questionList = [];
    var quizLength = response['quiz']['question'].length;
    for (var i = 0; i < quizLength; i++) {
      var type = response['quiz']['question'][i]['type'];
      var question = (type == 1)
          ? MultipleChoiceQuestion.option(
              response['quiz']['question'][i]['option'])
          : FillInQuestion();

      question.setStem(response['quiz']['question'][i]['stem']);
      question.setAnswer(response['quiz']['question'][i]['answer'].toString());
      questionList.add(question);
    }
    return questionList;
  }

  dynamic parseJson(var response) {
    return json.decode(response);
  }
}

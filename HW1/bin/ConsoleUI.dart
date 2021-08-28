import 'dart:io';

import 'package:http/http.dart';

import 'WebClient.dart';

/// class that controls the outputs to the console
class ConsoleUI {
  var webService = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz/';

  String getURL() {
    return webService;
  }

  String getUserChoice(var response) {
    print('Type something!:');
    var line = stdin.readLineSync();
    var userChoice = line.toString();
    // webService = webService;
    return webService;
  }

  String selectQuiz() {
    print(
        'Hello user! What quiz would you like to take? \nEnter a number 0-99:');
    var line = stdin.readLineSync();
    var userChoice = parseInt(line);
    if (userChoice < 10) {
      webService = webService + '?quiz=quiz0' + userChoice.toString();
    } else {
      webService = webService + '?quiz=quiz' + userChoice.toString();
    }
    return webService;
  }

  String takeQuiz(var response) {
    var quizLength = response['quiz']['question'].length;
    print("\n\nThis quiz has " + quizLength.toString() + " questions!");

    for (var i = 0; i < quizLength; i++) {
      //type 1 = choices
      var type = response['quiz']['question'][i]['type'];
      var question = response['quiz']['question'][i]['stem'];
      var choices = response['quiz']['question'][i]['option'];
      var answer = response['quiz']['question'][i]['answer'];
      print("\u001b[32mQuestion " + (i + 1).toString() + "\u001b[0m");
      print(question);
      if (type == 1) {
        for (var i = 0; i < choices.length; i++) {
          print((i + 1).toString() + '. ' + choices[i]);
        }
      }
      print("\n");
    }
  }

  void displayScore(var score) {
    //if score < 90
    //< 80
    //<70
  }

  int parseInt(var line) {
    try {
      if (line.isEmpty) {
        return 1;
      }
      var selection = int.parse(line);
      return selection;
    } on FormatException {
      print('Invalid Input: ' + line);
    }
    return -1;
  }
}

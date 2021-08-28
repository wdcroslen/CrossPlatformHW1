import 'dart:io';

import 'package:http/http.dart';

import 'WebClient.dart';

/// Class that controls the User Inputs and Outputs to the console
class ConsoleUI {
  var webService = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz/';

  String getURL() {
    return webService;
  }

  String start(var webClient) {
    print(
        'Hello user! What would you like to do? \n1. Practice\n2. Take a Quiz');
    var line = stdin.readLineSync();
    if (int.parse(line) == 1) {
      return "Practice";
    } else {
      print('What quiz would you like to take? \nEnter a number 0-99:');
      var line = stdin.readLineSync();
      var userChoice = int.parse(line);
      return webClient.getQuiz(userChoice, webService);
    }
  }

  String takeQuiz(var response) {
    var quizLength = response['quiz']['question'].length;
    print("\n\nThis quiz has " + quizLength.toString() + " questions!");
    var answers = [];
    var userChoices = [
      1,
      "Dart",
      1,
      "1",
      "build",
      1,
      1,
      'doctor',
      'hot reloading',
      1
    ];
    var userChoice;
    for (var i = 0; i < quizLength; i++) {
      //type 1 = choices
      var type = response['quiz']['question'][i]['type'];
      var question = response['quiz']['question'][i]['stem'];
      var choices = response['quiz']['question'][i]['option'];
      answers.add(response['quiz']['question'][i]['answer']);
      print("\u001b[32mQuestion " + (i + 1).toString() + "\u001b[0m");
      print(question);
      if (type == 1) {
        for (var i = 0; i < choices.length; i++) {
          print((i + 1).toString() + '. ' + choices[i]);
        }
        //   userChoice = int.parse(stdin.readLineSync());
        // } else {
        //   userChoice = stdin.readLineSync();
      }
      // userChoices.add(userChoice);
      print(answers);
    }
    return _getScore(answers, userChoices);
  }

  void displayScore(var score) {
    //if score < 90
    //< 80
    //<70
  }
  String _getScore(var answers, var userChoices) {
    var score = 0;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i] is List) {
        for (var j = 0; j < answers[i].length; j++) {
          if (answers[i][j].toLowerCase() ==
              userChoices[i].toString().toLowerCase()) {
            score++;
            break;
          }
        }
      }
      if (answers[i] == userChoices[i]) {
        score++;
      }
    }
    print(score);
    return null;
    //note that the open ended answers are in a list and can be any choice in the list
  }
}

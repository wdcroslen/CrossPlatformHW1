import 'dart:io';

import 'package:http/http.dart';

import 'WebClient.dart';

/// Class that controls the User Inputs and Outputs to the console
class ConsoleUI {
  var webService = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz/';
  var questionsWrong = [];
  var quizLength = 0;
  var answers = [];

  String getURL() {
    return webService;
  }

  int getQuizLength() {
    return quizLength;
  }

  List getAnswers() {
    return answers;
  }

  String start(var webClient) {
    questionsWrong = [];
    quizLength = 0;
    print(
        'Hello user! What would you like to do? \n1. Practice\n2. Take a Quiz');
    var line = stdin.readLineSync();
    if (int.parse(line) == 1) {
      print("How long do you want your quiz?");
      quizLength = int.parse(stdin.readLineSync());
      return "Practice";
    } else {
      print('What quiz would you like to take? \nEnter a number 0-99:');
      var line = stdin.readLineSync();
      var userChoice = int.parse(line);
      return webClient.getQuiz(userChoice, webService);
    }
  }

  /// This method displays the selected quiz and let's the user respond.
  int takeQuiz(var response) {
    quizLength = response['quiz']['question'].length;
    print("\n\nThis quiz has " + quizLength.toString() + " questions!");
    var userChoices = [];
    var userChoice;
    for (var i = 0; i < quizLength; i++) {
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
        userChoice = int.parse(stdin.readLineSync());
      } else {
        userChoice = stdin.readLineSync();
      }
      userChoices.add(userChoice);
    }
    return _getScore(answers, userChoices);
  }

  /// Displays the score to the user
  void displayScore(var score) {
    var grade = score / quizLength * 100;
    switch (grade ~/ 10) {
      case 10:
        {
          print("\u001b[36mGrade " + grade.toString() + "%\u001b[0m");
          print("Outstanding work! Perfect score!");
          break;
        }
      case 9:
        {
          var missed = "You missed question: ";
          missed = missed + questionsWrong[0].toString();
          print("\u001b[33mGrade " + grade.toString() + "%\u001b[0m");
          break;
        }
      case 0:
        {
          var missed = "You missed questions: ";
          for (var i = 0; i < questionsWrong.length - 1; i++) {
            missed = missed + questionsWrong[i].toString() + ' ';
          }
          missed = missed +
              'and ' +
              questionsWrong[questionsWrong.length - 1].toString();
          print("\u001b[31mGrade " + grade.toString() + "%\u001b[0m");
          break;
        }
      default:
        {
          var missed = "You missed questions: ";
          for (var i = 0; i < questionsWrong.length - 1; i++) {
            missed = missed + questionsWrong[i].toString() + ' ';
          }
          missed = missed +
              'and ' +
              questionsWrong[questionsWrong.length - 1].toString();
          print("\u001b[33mGrade " + grade.toString() + "%\u001b[0m");
        }
        break;
    }
  }

  /// Helper method to calculate the score of the user based on their choices
  int _getScore(var answers, var userChoices) {
    var score = 0;
    var current = score;
    for (var i = 0; i < answers.length; i++) {
      current = score;
      if (answers[i] is List) {
        for (var j = 0; j < answers[i].length; j++) {
          if (answers[i][j].toLowerCase() ==
              userChoices[i].toString().toLowerCase()) {
            score++;
            break;
          }
        }
      } else if (answers[i] == userChoices[i]) {
        score++;
      }
      if (current == score) {
        questionsWrong.add(i + 1);
      }
    }
    return score;
  }
}

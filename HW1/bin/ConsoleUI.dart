import 'dart:io';

/// Class that controls the User Inputs and Outputs to the console
class ConsoleUI {
  var webService = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz/';
  var questionsWrong = [];
  var questionList = [];
  var quizLength = 0;

  String start(var webClient) {
    quizLength = 0;
    print(
        'Hello user! What would you like to do? \n1. Practice\n2. Take a Quiz');
    var line = stdin.readLineSync();
    if (line == '1') {
      print("How long do you want your quiz?");
      quizLength = int.parse(stdin.readLineSync());
      return "Practice";
    } else {
      print('What quiz would you like to take? \nEnter a number 0-10:');
      var line = stdin.readLineSync();
      var userChoice = int.parse(line);
      return webClient.getQuiz(userChoice, webService);
    }
  }

  /// This method displays the selected quiz and let's the user respond.
  int takeQuiz(var questionList) {
    quizLength = questionList.length;
    print("\nThis quiz has " + quizLength.toString() + " questions!");
    var userChoice;
    var i = 0;
    while (i < quizLength) {
      print("\u001b[32mQuestion " + (i + 1).toString() + "\u001b[0m");
      print(questionList[i].getStem());
      if (questionList[i].runtimeType.toString() == 'MultipleChoiceQuestion') {
        questionList[i].displayOptions();
      }
      print("Enter your answer, p[revious] or n[ext] (default)");
      userChoice = stdin.readLineSync();
      if (userChoice == 'p' && i > 0) {
        i--;
        continue;
      } else if (userChoice == 'n' && i < quizLength - 1) {
        i++;
        continue;
      }
      questionList[i].setUserAnswer(userChoice);
      i++;
    }
    this.questionList = questionList;

    return _getScore(questionList);
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
      case 0:
        {
          print("\u001b[31mGrade " + grade.toString() + "%\u001b[0m");
          break;
        }
      default:
        {
          print("\u001b[33mGrade " + grade.toString() + "%\u001b[0m");
        }
        break;
    }
    _printAnswers();
    if (!questionsWrong.isEmpty) {
      print("Would you like to review your missed questions?  [Y/N]");
      var line = stdin.readLineSync();
      if (line.toLowerCase() == "y") {
        var score = takeQuiz(questionsWrong);
        displayScore(score);
        return;
      }
    }
    print("Goodbye!");
  }

  /// Helper method to calculate the score of the user based on their choices
  int _getScore(var questionList) {
    questionsWrong = [];
    var score = 0;
    for (var i = 0; i < questionList.length; i++) {
      if (questionList[i].isCorrect()) {
        score++;
      } else {
        questionsWrong.add(questionList[i]);
      }
    }
    return score;
  }

  List _printAnswers() {
    var answerList = [];
    for (var i = 0; i < questionList.length; i++) {
      answerList.add(questionList[i].getAnswer());
    }
    print(answerList);
  }
}

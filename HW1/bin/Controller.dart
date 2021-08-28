import 'ConsoleUI.dart';
import 'WebClient.dart';

// William Croslen
///main controller method that calls all the other methods and classes

class Controller {
  var console = ConsoleUI();
  var webService;

  Future<void> start() async {
    var webClient = WebClient();
    var webService = console.getURL();
    var quiz = console.selectQuiz();
    var response = await webClient.getResponse(Uri.parse(quiz));
    var score = console.takeQuiz(response);

    console.displayScore(score);
  }
}

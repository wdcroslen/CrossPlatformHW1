import 'ConsoleUI.dart';
import 'WebClient.dart';

// William Croslen
/// Main controller method that calls all the other methods and classes

class Controller {
  var console = ConsoleUI();
  var webService;

  Future<void> start() async {
    var webClient = WebClient();
    var webService = console.getURL();
    var quiz = console.start(webClient);

    if (quiz == "Practice") {
      var practiceQuiz = await webClient.generatePracticeQuiz(
          console.getQuizLength(), webService);
      print("Here is your practice");

      var score = console.takeQuiz(practiceQuiz);
      console.displayScore(score);

      return;
    }

    var response = await webClient.getResponse(Uri.parse(quiz));
    var score = console.takeQuiz(response);

    console.displayScore(score);
  }
}

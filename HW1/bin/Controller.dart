import 'ConsoleUI.dart';
import 'WebClient.dart';

// William Croslen
/// Main controller method that calls all the other methods and classes

class Controller {
  var console = ConsoleUI();
  var webService;

  Future<void> start() async {
    var webClient = WebClient();
    var webService = console.webService;
    var quiz = console.start(webClient);

    if (quiz == "Practice") {
      var practiceQuiz =
          await webClient.generatePracticeQuiz(console.quizLength, webService);
      var score = console.takeQuiz(practiceQuiz);
      console.displayScore(score);
      return;
    }

    var response = await webClient.getResponse(Uri.parse(quiz));
    var generatedQuiz = await webClient.generateQuiz(response);
    var score = console.takeQuiz(generatedQuiz);

    console.displayScore(score);
  }
}

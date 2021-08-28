import 'ConsoleUI.dart';
import 'WebClient.dart';

// William Croslen
///main controller method that calls all the other methods and classes
///
///
class Controller {
  var console = ConsoleUI();
  var webService;

  Future<void> start() async {
    var webClient = WebClient();
    var webService = console.getURL();
    // print(webService);
    // var response = await webClient.getResponse(Uri.parse(webService));
    // print(response.toString());
    var quiz = console.selectQuiz();
    var response = await webClient.getResponse(Uri.parse(quiz));
    var score = console.takeQuiz(response);

    console.displayScore(score);

    // var board = Board();
    // var response = await wClient.getResponse(url, console.getDefault());
    // var strategy = console.getUserStrat(response);
    // print('Selected Strategy: $strategy');

    // var end = url.length - 4;
    // var game = url.substring(0, end) + 'new/?strategy=$strategy';
    // url = url.substring(0, end);
    // response = await wClient.getResponse(game, game);
    // print(game);
    // print(response);
    // var pid = response['pid'];
    // var boardFile = url + '/play/data/' + '$pid.txt';

    // var current;
    // var done = false;
    // while (!done) {
    //   ///Continuee playing the game
    //   var move = console.promptMove();
    //   var moveResponse = await wClient.playGame(
    //       url, move, pid); //= await wClient.getResponse(boardFile,boardFile);
    //   print("Here is the Current Board: \n");
    //   current = await wClient.getResponse(boardFile, boardFile);
    //   board.displayBoard(current);
    //   done = board.gameOver(moveResponse);
    // }

    // ///Highlight Board when the game is done
    // board.highlight(current);
    // print('Thank you for Playing!');
  }
}

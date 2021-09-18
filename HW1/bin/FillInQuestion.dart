import 'Question.dart';

class FillInQuestion extends Question {
  bool isCorrect() {
    return getAnswer().toLowerCase() == getUserAnswer().toLowerCase();
  }
}

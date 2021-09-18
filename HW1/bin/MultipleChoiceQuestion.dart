import 'Question.dart';

class MultipleChoiceQuestion extends Question {
  var _options = [];

  MultipleChoiceQuestion.option(this._options) {
    setOptions(this._options);
  }

  List getOptions() {
    return this._options;
  }

  void setOptions(List options) {
    this._options = options;
  }

  void displayOptions() {
    if (_options == null) {
      return;
    }
    for (var i = 0; i < _options.length; i++) {
      print("\u001b[36m " +
          (i + 1).toString() +
          ". \u001b[0m" +
          _options[i].toString());
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  BuildContext context;
  final int _maxQuestionAmount = 10;
  List? questions;
  int _currentQuestionCount = 0;

  GamePageProvider({required this.context}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    print("Hello");
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var _response = await _dio.get('', queryParameters: {
      'amount': 10,
      'type' : 'boolean',
      'difficulty' : 'easy',
    });
    var _data = jsonDecode(_response.toString());
    //print(_data);
    questions = _data['results'];
    print(questions);
    notifyListeners();
  }

  String getCurrentQuestionText(){
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String _answer) async{
    bool isCorrect = questions! [_currentQuestionCount]['correct_answer'] == _answer;
    _currentQuestionCount++;
    print(isCorrect ? "Correct" : "Incorrect");
    notifyListeners();
  }
}

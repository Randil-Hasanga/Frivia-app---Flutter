import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  BuildContext context;
  final int _maxQuestionAmount = 10;
  final String difficultyLevel;
  List? questions;
  int _currentQuestionCount = 0;
  int _correctAnswerCount = 0;

  GamePageProvider({required this.context, required this.difficultyLevel}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    print("Hello");
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    print(difficultyLevel);
    var _response = await _dio.get('', queryParameters: {
      'amount': '$_maxQuestionAmount',
      'type': 'boolean',
      'difficulty': '$difficultyLevel',
    });
    var _data = jsonDecode(_response.toString());
    //print(_data);
    questions = _data['results'];
    print(questions);
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]['correct_answer'] == _answer;
    
    if(isCorrect){
      _correctAnswerCount++;
    }
    _currentQuestionCount++;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );

    //delay 1 second
    await Future.delayed(
      const Duration(seconds: 1),
    );

    //display context
    Navigator.pop(context);
    if (_currentQuestionCount == 10) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End of the game !",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          content: Text("Score : $_correctAnswerCount/$_maxQuestionAmount"),
          
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:frivia/providers/game_page_providers.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  GamePage({Key? key}) : super(key: key);
  double? _deviceWidth, _deviceHeight;

  GamePageProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context) => GamePageProvider(context: context),
      child: _buildUI(),
      
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      print("1");
      _pageProvider = _context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceHeight! * 0.05,
              ),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.01,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Text(
        "True",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double _currentDifficulty = 0;
  final List<String> _difficultyTexts = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _homeTitle(),
                _difficultySlider(),
                _startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeTitle() {
    return Column(
      children: [
        const Text(
          "Frivia",
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(),
        Text(
          _difficultyTexts[_currentDifficulty.toInt()],
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _startButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext _context) {
              return GamePage(difficultyLevel: _difficultyTexts[_currentDifficulty.toInt()].toLowerCase(),);
            },
          ),
        );
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.08,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _difficultySlider() {
    return Column(
      children: [
        Slider(
          label: _difficultyTexts[_currentDifficulty.toInt()],
          min: 0,
          max: 2,
          divisions: 2,
          thumbColor: Colors.white,
          activeColor: Colors.blue,
          value: _currentDifficulty,
          onChanged: (_value) {
            setState(() {
              _currentDifficulty = _value;
              print(_currentDifficulty);
            });
          },
        ),
        const Text("Difficulty",style: TextStyle(color: Colors.white,),),
      ],
    );
  }
}

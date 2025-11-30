import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SubtractionsQuizGame extends StatefulWidget {
  @override
  _SubtractionsQuizGameState createState() => _SubtractionsQuizGameState();
}

class _SubtractionsQuizGameState extends State<SubtractionsQuizGame> {
  final List<Map<String, dynamic>> questions = [
    {"question": "25 - 17", "options": [8, 9, 7, 6], "answer": 8},
    {"question": "43 - 19", "options": [22, 24, 23, 25], "answer": 24},
    {"question": "56 - 29", "options": [26, 27, 28, 29], "answer": 27},
    {"question": "75 - 48", "options": [27, 28, 29, 26], "answer": 27},
    {"question": "94 - 57", "options": [37, 38, 36, 39], "answer": 37},
    {"question": "81 - 64", "options": [16, 17, 18, 19], "answer": 17},
    {"question": "69 - 32", "options": [36, 37, 38, 35], "answer": 37},
    {"question": "123 - 45", "options": [77, 78, 79, 80], "answer": 78},
    {"question": "98 - 67", "options": [31, 30, 32, 29], "answer": 31},
    {"question": "105 - 58", "options": [47, 46, 48, 49], "answer": 47},
    {"question": "76 - 29", "options": [47, 48, 49, 46], "answer": 47},
    {"question": "53 - 28", "options": [25, 24, 23, 22], "answer": 25},
    {"question": "112 - 78", "options": [34, 33, 32, 35], "answer": 34},
    {"question": "67 - 39", "options": [28, 27, 26, 29], "answer": 28},
  ];


  int currentQuestionIndex = 0;
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  bool gameOver = false;
  bool showFullScreenAnimation = false;
  String animationUrl = '';

  void checkAnswer(int selectedOption) {
    if (gameOver) return;

    if (selectedOption == questions[currentQuestionIndex]['answer']) {
      setState(() {
        score += 5;
        correctAnswers += 1;
        showFullScreenAnimation = true;
        animationUrl =
            'https://lottie.host/2ab7ce83-6b84-4b02-9247-812917be1e99/D8pg5egsrz.json';
      });
    } else {
      setState(() {
        score -= 5;
        wrongAnswers += 1;
        showFullScreenAnimation = true;
        animationUrl =
            'https://lottie.host/028e3a44-50db-4d4c-84a0-66781c6710aa/1s9ab4Blvc.json';
      });
    }

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showFullScreenAnimation = false;
      });
      if (currentQuestionIndex == questions.length - 1) {
        setState(() {
          gameOver = true;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex += 1;
      });
    } else {
      setState(() {
        gameOver = true;
      });
    }
  }

  void _resetGame() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      correctAnswers = 0;
      wrongAnswers = 0;
      gameOver = false;
    });
  }

  void _goToHomeScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    List<int> options = questions[currentQuestionIndex]['options'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events_outlined, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  "Score: $score",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.grade_outlined, color: Colors.red),
                SizedBox(width: 4),
                Text(
                  "Level 2",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          questions[currentQuestionIndex]['question'],
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Select the correct answer:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: options.map((option) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            option.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            checkAnswer(option);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (showFullScreenAnimation)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Lottie.network(
                  animationUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (gameOver)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/pencils-1280558.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Game Over!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Correct Answers: $correctAnswers",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "Wrong Answers: $wrongAnswers",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _resetGame,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Restart Game",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _goToHomeScreen,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Home",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

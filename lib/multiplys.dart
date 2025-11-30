import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MultiplicationsQuizGame extends StatefulWidget {
  @override
  _MultiplicationsQuizGameState createState() => _MultiplicationsQuizGameState();
}

class _MultiplicationsQuizGameState extends State<MultiplicationsQuizGame> {
  final List<Map<String, dynamic>> questions = [
    {"question": "12 * 15", "options": [180, 175, 185, 170], "answer": 180},
    {"question": "14 * 19", "options": [266, 276, 286, 256], "answer": 266},
    {"question": "16 * 17", "options": [272, 262, 282, 252], "answer": 272},
    {"question": "18 * 13", "options": [234, 224, 244, 214], "answer": 234},
    {"question": "19 * 11", "options": [209, 219, 229, 199], "answer": 209},
    {"question": "20 * 21", "options": [420, 400, 440, 410], "answer": 420},
    {"question": "22 * 18", "options": [396, 386, 376, 366], "answer": 396},
    {"question": "23 * 17", "options": [391, 381, 371, 361], "answer": 391},
    {"question": "24 * 16", "options": [384, 374, 364, 354], "answer": 384},
    {"question": "25 * 14", "options": [350, 340, 360, 330], "answer": 350},
    {"question": "26 * 13", "options": [338, 328, 318, 308], "answer": 338},
    {"question": "27 * 12", "options": [324, 314, 304, 294], "answer": 324},
    {"question": "28 * 15", "options": [420, 410, 400, 390], "answer": 420},
    {"question": "30 * 16", "options": [480, 470, 460, 450], "answer": 480},
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

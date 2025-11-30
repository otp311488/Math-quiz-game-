import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class MultiplicationQuizGame extends StatefulWidget {
  @override
  _MultiplicationQuizGameState createState() => _MultiplicationQuizGameState();
}

class _MultiplicationQuizGameState extends State<MultiplicationQuizGame> {
  final List<Map<String, dynamic>> questions = [
    {"question": "5 * 3", "options": [15, 12, 10, 20], "answer": 15},
    {"question": "6 * 2", "options": [12, 18, 16, 14], "answer": 12},
    {"question": "8 * 4", "options": [32, 24, 36, 28], "answer": 32},
    {"question": "7 * 1", "options": [7, 14, 21, 10], "answer": 7},
    {"question": "9 * 5", "options": [45, 40, 35, 50], "answer": 45},
    {"question": "10 * 6", "options": [60, 50, 70, 55], "answer": 60},
    {"question": "8 * 3", "options": [24, 30, 20, 18], "answer": 24},
    {"question": "7 * 0", "options": [0, 7, 14, 21], "answer": 0},
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
   void _goToLevel2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MultiplicationQuizGame()),
    );
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
                  "Level 1",
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
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Restart",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _goToHomeScreen,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Home",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _goToLevel2,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Level 2",
                            style: TextStyle(fontSize: 18),
                          ),
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
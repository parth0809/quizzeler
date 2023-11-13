import 'package:flutter/material.dart';
import 'package:quizzeler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  List<Widget> scoreKeeper = [];
  int score = 0;
  void checkAnswer(bool b) {
    bool correctAnswer = quizBrain.getAnswerText();
    if (correctAnswer == b) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.pink));
    }
    setState(() {
      if (quizBrain.isFinished == true) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Finished",
          desc: "You have reached the end of the quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => {
                quizBrain.resetPg(),
                scoreKeeper = [],
                Navigator.pop(context)
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        quizBrain.nextQs();
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                onPressed: () {
                  setState(() {
                    quizBrain.getQuestionText();
                    checkAnswer(true);
                  });
                },
                child: Text(
                  'True',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pink),
                onPressed: () {
                  setState(() {
                    quizBrain.getQuestionText();
                    checkAnswer(false);
                  });
                },
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ]);
  }
}

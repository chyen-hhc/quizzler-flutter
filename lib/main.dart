import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz.dart';

Quiz quiz = Quiz();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        )),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Icon createIcon(bool a) {
    return a
        ? Icon(Icons.check, color: Colors.green)
        : Icon(Icons.close, color: Colors.red);
  }

  int trueAns = 0, falseAns = 0;
  void callAlert() {
    Alert(
        context: context,
        title: 'FINISH!',
        type: AlertType.success,
        desc: 'Your result is $trueAns/${falseAns + trueAns}',
        buttons: [
          DialogButton(
            child: Text(
              "DONE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ]).show();
  }

  void saveQuiz(bool userAns) {
    bool ans = quiz.getAnswer();

    if (quiz.isFinish())
      callAlert();
    else {
      if (ans == userAns) {
        {
          scoreKeeper.add(createIcon(true));
          trueAns++;
        }
      } else {
        scoreKeeper.add(createIcon(false));
        falseAns++;
      }
    }
  }

  List<Icon> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz.getContent(),
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
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                saveQuiz(true);
                setState(() {
                  quiz.nextQuestion();
                });
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                saveQuiz(false);
                setState(() {
                  quiz.nextQuestion();
                });
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}

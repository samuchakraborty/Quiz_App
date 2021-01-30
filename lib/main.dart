import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quizzer_flutter/quizbrain.dart';

void main() => runApp(Quizzler());
Quizbrain quizBrain = Quizbrain();

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
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List<String> questionList = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];

  //int questionNumber = 0;

  // Question question = Question(
  //     q: 'You can lead a cow down stairs but not up stairs.', a: false);

  // List<Question> questionListAll = [
  //   Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
  //   Question(
  //       q: 'Approximately one quarter of human bones are in the feet.',
  //       a: true),
  //   Question(q: 'A slug\'s blood is green.', a: true),
  // ];

  //List<bool> answerList = [false, true, true];

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool answer) {
    var correctAnswer = quizBrain.getAnswer();

    // if (answer == correctAnswer) {
    //   scoreKeeper.add(Icon(
    //     Icons.check,
    //     color: Colors.green,
    //   ));
    // } else {
    //   scoreKeeper.add(Icon(
    //     Icons.close,
    //     color: Colors.red,
    //   ));
    setState(
      () {
        //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz.
        // If true, execute Part A, B, C, D.
        //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        //HINT! Step 4 Part B is in the quiz_brain.dart
        //TODO: Step 4 Part C - reset the questionNumber,
        //TODO: Step 4 Part D - empty out the scoreKeeper.
        if (quizBrain.isFinished() == true) {
          Alert(
            context: context,
            title: 'Finished',
            desc: 'You\'ve reached the end of the quiz.',
          ).show();

          quizBrain.reset();
          scoreKeeper = [];
        }
        //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
        else {
          if (answer == correctAnswer) {
            scoreKeeper.add(Icon(
              Icons.check,
              color: Colors.green,
            ));
          } else {
            scoreKeeper.add(Icon(
              Icons.close,
              color: Colors.red,
            ));
          }
          quizBrain.getQuestionNumber();
        }
      },
    );
  }

  // setState(() {
  //   quizBrain.getQuestionNumber();
  // });
//  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                //  var correctAnswer = answerList[questionNumber];
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15.0),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(14),
            // ),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                //  var correctAnswer = answerList[questionNumber];
                checkAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper

        Expanded(
          child: Row(children: scoreKeeper),
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/data/data.dart';
import 'package:flutter_quiz_app/model/questionmodel.dart';
import 'package:flutter_quiz_app/views/results.dart';

class QuizPlay extends StatefulWidget {
  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay>
    with SingleTickerProviderStateMixin {
  List<QuestionModel> questions = new List<QuestionModel>();
  int index = 0;
  int correct = 0, incorrect = 0, notAttempted = 0, points = 0;

  double beginAnim = 0.0;
  double endAnim = 1.0;

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    questions = getQuestion();

    animationController = new AnimationController(
        duration: const Duration(seconds: 4), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    animation =
        Tween(begin: beginAnim, end: endAnim).animate(animationController);
    startAnim();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (index < questions.length - 1) {
            index++;
            resetAnim();
            startAnim();
            notAttempted++;
          } else {
            notAttempted++;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Result(
                          score: points,
                          totalQuestions: questions.length,
                          correct: correct,
                          incorrect: incorrect,
                          notattempted: notAttempted,
                        )));
          }
        });
      }
    });
  }

  startAnim() {
    animationController.forward();
  }

  resetAnim() {
    animationController.reset();
  }

  stopAnim() {
    animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60),
        child: Column(
          //Column used for vertical arrangement
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                //Row used for horizontal arrangement
                children: [
                  Text(
                    "${index + 1}/${questions.length}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Question",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  Spacer(), //Need to understand how does spacer works
                  Text(
                    "${points}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Points",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ), // first row wise children

            Text(
              "${questions[index].getQuestion()}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.grey),
            ),

            SizedBox(
              height: 20,
            ),
            LinearProgressIndicator(
              value: animation.value,
            ),
            SizedBox(height: 40,),
            Container(
              height: 200,
              child: Image(
                  image:
                      CachedNetworkImageProvider(questions[index].getImageUrl())),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (questions[index].getAnswer() == "True") {
                          setState(() {
                            points = points + 20;
                            index++;
                            correct++;
                            resetAnim();
                            startAnim();
                          });
                        } else {
                          setState(() {
                            points = points - 5;
                            index++;
                            incorrect++;
                            resetAnim();
                            startAnim();
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.blue),
                        child: Text(
                          "True",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (questions[index].getAnswer() == "False") {
                          setState(() {
                            points = points + 20;
                            index++;
                            correct++;
                            resetAnim();
                            startAnim();
                          });
                        } else {
                          setState(() {
                            points = points - 5;
                            index++;
                            incorrect++;
                            resetAnim();
                            startAnim();
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.red),
                        child: Text(
                          "False",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/views/home.dart';
import 'package:flutter_quiz_app/views/quiz_play.dart';

class Result extends StatefulWidget {
  int score, totalQuestions, correct, incorrect, notattempted;

  Result(
      {this.score,
      this.totalQuestions,
      this.correct,
      this.incorrect,
      this.notattempted});

  @override
  State<StatefulWidget> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String greeting = "";

  @override
  void initState() {
    var percentage = (widget.score / widget.totalQuestions * 20) * 100;

    if (percentage >= 90) {
      greeting = "outstanding";
    } else if (percentage > 80 && percentage < 90) {
      greeting = "good work";
    } else if (percentage > 70 && percentage < 80) {
      greeting = "good effort";
    } else if (percentage < 70) {
      greeting = "needs improvement";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${greeting}", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text(
                "You Scored ${widget.score} out of ${widget.totalQuestions * 20}"),
            SizedBox(height: 20,),
            Text(
                "${widget.correct} correct , ${widget.incorrect} incorrect & ${widget.notattempted} not attempted out of ${widget.totalQuestions}"),
            SizedBox(height: 12,),
            GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => QuizPlay()));
                },

                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 54),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.blue
                  ),
                  child: Text("Replay Quiz Now", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },

              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 54),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  border: Border.all(color: Colors.blue,width: 2)
                ),
                child: Text("Go to Home", style: TextStyle(fontSize: 15 , color: Colors.blue),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

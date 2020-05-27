import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quiz_app/views/quiz_play.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          print("I am clicked");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => QuizPlay()));
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Start Quiz Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

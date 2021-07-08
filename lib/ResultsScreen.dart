import 'package:flutter/material.dart';

import 'package:quizapp/quizscreen.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  ResultScreen({required this.score});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          // it can accept multiple widget
          children: <Widget>[
            SizedBox(
              height: 90,
            ),

            Center(
              child: Image(
                image: AssetImage("assets/qa.png"),
                height: 250,
                width: 250,
              ),
            ),

            Text(
              "Score",
              style: TextStyle(
                color: Colors.white,
                fontSize: 90,
              ),
            ),

            Text(
              "$score/10",
              style: TextStyle(
                color: Colors.red,
                fontSize: 90,
              ),
            ),
            // ignore: deprecated_member_use
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "Restart",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                color: Color(0xFFFFBA00),
                textColor: Colors.white,
                onPressed: () {
                  //go to quiz screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizScreen()));
                },
              ),
            ),


            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "Exit",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  //exit
                  Navigator.pop(context);
                },
              ),
            ),


            



          ],

          
        ),

          

      )),

      


    );

    
  }
}

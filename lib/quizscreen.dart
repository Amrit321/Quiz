import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:quizapp/ResultsScreen.dart';

import 'QuizHelper.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();

  
}

class _QuizScreenState extends State<QuizScreen> {


  var apiURL =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";


  
  late QuizHelper quizHelper;

 
  

  int currentQuestion = 0;
  int totalSeconds = 30;
  int elapsedSecond = 0;
 

 late Timer timer;
 int score = 0;


  
   

  @override

  
  void initState() {
    fetchAllQuiz();

    // fetch questions here
    // init state will initate the variable
    super.initState();
  }
  

  

  fetchAllQuiz() async {
    // ignore: unused_local_variable
    var response = await http.get(Uri.parse(apiURL));
    var body = response.body;
    var json = jsonDecode(body);
    
    

    setState(() {
      quizHelper = QuizHelper.fromjson(json);
      quizHelper.results[currentQuestion].incorrectAnswers.add(quizHelper.results[currentQuestion].correctAnswer);

      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();
    });

  }
  initTimer(){
   timer = Timer.periodic(Duration(seconds: 1),(t) { 

     if (t.tick == totalSeconds) {
       print("Time Completed");
       t.cancel();

       changeQuestion();
       
     }else{
       setState(() {
         elapsedSecond = t.tick;
       });
     }

   });
  }

    @override
    void dispose(){
      timer.cancel();
      super.dispose();
    }
  
  checkAnswer(answer){
    String? correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
if (correctAnswer == answer) {
  score += 1;

  
}
else{
  print("Incorrect");
}
changeQuestion();


  }

  changeQuestion(){

    timer.cancel();
    // check if it is last question

    if (currentQuestion == quizHelper.results.length-1) {

      print("Quiz Completed");
      print("Score: $score");
      // navigate to result screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultScreen(score: score, ),
      ),);

      
    }else{

      setState(() {
        currentQuestion +=1;
      });

       quizHelper.results[currentQuestion].incorrectAnswers.add(quizHelper.results[currentQuestion].correctAnswer);

      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();

    }





  }
  

  @override
  
  Widget build(BuildContext context) {
    
    // ignore: unnecessary_null_comparison
    if (quizHelper != null) {
      return Scaffold(
        
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 60,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          "assets/qa.png",
                        ),
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        "$elapsedSecond s",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                // questions

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Q. ${quizHelper.results[currentQuestion].question}",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // options
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  child: Column(
                    children: 
                        quizHelper.results[currentQuestion].incorrectAnswers.map((option) {
                      // ignore: deprecated_member_use
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () {
                            checkAnswer(option);
                          },
                          color: Color(0xFF511AAB),
                          colorBrightness: Brightness.dark,
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

import 'package:driving_test_app/select%20quiz.dart';
import 'package:flutter/material.dart';
import 'package:driving_test_app/home_Screen.dart';
import 'package:driving_test_app/question_data/Question.dart';
import 'package:driving_test_app/ReviewAnswersPage.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswer;
  final String resultMessage;
  final int quizNumber;
  final List<Question> questions;
  final List<int> selectedAnswers;
  final int totalQuestions;

  const ResultScreen({
    Key? key,
    required this.correctAnswer,
    required this.resultMessage,
    required this.quizNumber,
    required this.questions,
    required this.selectedAnswers,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scorePercentage = (correctAnswer / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: false,
        title: const Text(
          'نتایج آزمون',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '$correctAnswer',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black, fontSize: 30),
              ),
              Container(
                width: 256,
                height: 256,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red[800]!, width: 6),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: 300,
            height: 96,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                resultMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(height: 35),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                fixedSize: const Size(190, 46),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReviewAnswersPage(
                    questions: questions,
                    selectedAnswers: selectedAnswers,
                    correctAnswer: correctAnswer,
                    resultMessage: resultMessage,
                    quizNumber: quizNumber,
                    totalQuestions: totalQuestions,
                  ),
                ));
              },
              child: const Text(
                'مرور جواب‌ها',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'yekan',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                fixedSize: const Size(190, 46),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelectQuiz(),
                ));
              },
              child: const Text(
                'آزمون مجدد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'yekan',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                fixedSize: const Size(190, 46),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(scorePercentage: scorePercentage),
                ));
              },
              child: const Text(
                'بازگشت به خانه',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'yekan',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

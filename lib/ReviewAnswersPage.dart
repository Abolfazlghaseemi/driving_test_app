import 'package:driving_test_app/ResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:driving_test_app/question_data/Question.dart';
class ReviewAnswersPage extends StatelessWidget {
  final List<Question> questions;
  final List<int> selectedAnswers;
  final int correctAnswer;
  final String resultMessage;
  final int quizNumber;
  final int totalQuestions;

  const ReviewAnswersPage({
    Key? key,
    required this.questions,
    required this.selectedAnswers,
    required this.correctAnswer,
    required this.resultMessage,
    required this.quizNumber,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'مرور جواب‌ها',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  correctAnswer: correctAnswer,
                  resultMessage: resultMessage,
                  quizNumber: quizNumber,
                  questions: questions,
                  selectedAnswers: selectedAnswers,
                  totalQuestions: totalQuestions,
                ),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final selectedAnswer = selectedAnswers[index];
          final isCorrectAnswer = question.correctAnswer == selectedAnswer;

          return ListTile(
            title: Text(question.questionTitle ?? "سوال یافت نشد"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  question.answerList?.length ?? 0,
                  (answerIndex) {
                    return ListTile(
                      title: Text(question.answerList![answerIndex] ?? "گزینه‌ی ناموجود"),
                      leading: Radio(
                        value: answerIndex,
                        groupValue: selectedAnswer,
                        onChanged: (value) {},
                        activeColor: isCorrectAnswer ? Colors.green : Colors.red,
                      ),
                      tileColor: isCorrectAnswer
                          ? (answerIndex == question.correctAnswer
                              ? Colors.green[100]
                              : null)
                          : (answerIndex == selectedAnswer
                              ? Colors.red[100]
                              : null),
                    );
                  },
                ),
                if (!isCorrectAnswer)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'پاسخ صحیح: ${question.answerList?[question.correctAnswer] ?? "ناشناخته"}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

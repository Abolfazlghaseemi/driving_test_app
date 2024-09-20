import 'package:driving_test_app/color.dart';
import 'package:flutter/material.dart';
import 'package:driving_test_app/ResultScreen.dart';
import 'package:driving_test_app/question_data/Question.dart';
import 'package:driving_test_app/timer/QuizTimer.dart';
import 'package:driving_test_app/question_data/constants.dart';

class QuizPage extends StatefulWidget {
  final int quizNumber;
  final int durationInMinutes;

  const QuizPage({
    Key? key,
    required this.quizNumber,
    this.durationInMinutes = 20,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Question> questions;
  int shownQuestionIndex = 0;
  Question? selectedQuestion;
  bool isFinalAnswerSubmitted = false;
  int correctAnswer = 0;
  late QuizTimer _quizTimer;
  bool _isTimeUp = false;
  int? selectedOptionIndex;
  List<int> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    questions = getQuestionsForQuiz(widget.quizNumber);

    if (questions.isNotEmpty) {
      selectedQuestion = questions[shownQuestionIndex];
      selectedAnswers = List.filled(questions.length, -1);
    }

    _quizTimer = QuizTimer(widget.durationInMinutes);
    _quizTimer.start();
    _quizTimer.timeUpStream.listen((timeUp) {
      if (timeUp) {
        setState(() {
          _isTimeUp = true;
        });
        _showTimeUpDialog();
      }
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('زمان آزمون به پایان رسید'),
          content: const Text('وقت شما برای پاسخگویی به سوالات تمام شده است'),
          actions: <Widget>[
            TextButton(
              child: const Text('باشه'),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToResultScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToResultScreen() {
    final totalQuestions = questions.length;
    final wrongAnswers = selectedAnswers
        .where((answer) =>
            answer != -1 &&
            questions[selectedAnswers.indexOf(answer)].correctAnswer != answer)
        .length;

    final resultMessage = wrongAnswers > 3
        ? 'مردود شده‌اید تعداد غلط بیشتر از حد مجاز است'
        : 'شما قبول شدید';

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          correctAnswer: correctAnswer,
          totalQuestions: totalQuestions,
          resultMessage: resultMessage,
          quizNumber: widget.quizNumber,
          questions: questions,
          selectedAnswers: selectedAnswers,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quizTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        body: Center(child: const Text('سوالی برای نمایش وجود ندارد')),
      );
    }

    selectedQuestion = questions[shownQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'سوال ${shownQuestionIndex + 1} از ${questions.length}',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: _isTimeUp
            ? const Center(child: Text('زمان آزمون به پایان رسید'))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<int>(
                      stream: _quizTimer.remainingSecondsStream,
                      builder: (context, snapshot) {
                        final remainingSeconds = snapshot.data ?? 0;
                        final minutes =
                            (remainingSeconds ~/ 60).toString().padLeft(2, '0');
                        final seconds =
                            (remainingSeconds % 60).toString().padLeft(2, '0');

                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'زمان باقی‌مانده تا پایان آزمون\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: '$minutes:$seconds',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    if (selectedQuestion?.imageNameNumber != null)
                      Image(
                        width: 250,
                        image: AssetImage(
                            'assets/images/${selectedQuestion!.imageNameNumber}.png'),
                      ),
                    const SizedBox(height: 5),
                    Text(
                      selectedQuestion!.questionTitle ?? "عنوان سوال یافت نشد",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(
                      selectedQuestion!.answerList?.length ?? 0,
                      (index) => getOptionsItem(index),
                    ),
                    const SizedBox(height: 8),
                    if (isFinalAnswerSubmitted)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          fixedSize: const Size(190, 46),
                        ),
                        onPressed: _navigateToResultScreen,
                        child: const Text(
                          'پایان آزمون',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'yekan',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget getOptionsItem(int index) {
    bool isCorrectAnswer = selectedQuestion!.correctAnswer == index;
    bool isSelected = selectedOptionIndex == index;

    return ListTile(
      title: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: elevatedButton_quiz,
          border: Border.all(
            color: isSelected
                ? (isCorrectAnswer ? Colors.green : Colors.red)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          selectedQuestion!.answerList![index] ?? "گزینه‌ی ناموجود",
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      onTap: () {
        setState(() {
          selectedOptionIndex = index;
          selectedAnswers[shownQuestionIndex] = index;

          if (isCorrectAnswer) {
            correctAnswer++;
          }

          if (shownQuestionIndex == questions.length - 1) {
            isFinalAnswerSubmitted = true;
          } else {
            shownQuestionIndex++;
            selectedOptionIndex = null;
            selectedQuestion = questions[shownQuestionIndex];
          }
        });
      },
    );
  }
}

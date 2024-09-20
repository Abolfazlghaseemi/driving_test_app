import 'package:flutter/material.dart';
import 'package:driving_test_app/QuizPage.dart';
import 'package:driving_test_app/color.dart';

class SelectQuiz extends StatefulWidget {
  const SelectQuiz({super.key});

  @override
  State<SelectQuiz> createState() => _SelectQuizState();
}

class _SelectQuizState extends State<SelectQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                20,
                (index) {
                  int quizNumber = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: elevatedButton_quiz,
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.3), width: 2),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPage(
                              quizNumber: quizNumber,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 320,
                        height: 54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'زمان: 20 دقیقه',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                            Text(
                              'سوالات: 30',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(width: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'آزمون شماره $quizNumber',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

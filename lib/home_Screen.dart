import 'dart:math';
import 'package:flutter/material.dart';
import 'package:driving_test_app/color.dart';
import 'package:driving_test_app/select%20quiz.dart';

class HomeScreen extends StatefulWidget {
  final double scorePercentage;

  const HomeScreen({super.key, required this.scorePercentage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/images/logo/logo_2.png',
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 300,
              height: 178,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(colors: [color_Gradient, color_blue]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'درصد تسلط شما به آزمون',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/icon/icon.png',
                            width: 58,
                            height: 102,
                          ),
                          Image.asset(
                            'assets/images/icon/icon.png',
                            width: 58,
                            height: 102,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 35, left: 30, right: 30, bottom: 0),
                        child: Center(
                          child: Text(
                            '${widget.scorePercentage.toStringAsFixed(1)}%',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CustomPaint(
                            painter: DashedCirclePainter(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.scorePercentage >= 80
                        ? '.آفرین درصد قبولی شما بسیار بالاست'
                        : '.بیشتر مطالعه کنید و مجدد در آزمون شرکت کنید',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 70),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [elevatedButton_Color_Gradient, elevatedButton_Color],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(250, 60),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectQuiz(),
                    ),
                  );
                },
                child: Text(
                  'شروع آزمون',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = circle_Color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double dashLength = 10;
    final double gapLength = 8;
    final int segments = 10;

    final double totalLength = dashLength + gapLength;
    final double segmentAngle = (2 * pi) / segments;

    for (int i = 0; i < segments; i++) {
      final double startAngle = i * segmentAngle;
      final double endAngle =
          startAngle + (segmentAngle * (dashLength / totalLength));

      final Offset startPoint = Offset(
        size.width / 2 + radius * cos(startAngle),
        size.height / 2 + radius * sin(startAngle),
      );

      final Offset endPoint = Offset(
        size.width / 2 + radius * cos(endAngle),
        size.height / 2 + radius * sin(endAngle),
      );

      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

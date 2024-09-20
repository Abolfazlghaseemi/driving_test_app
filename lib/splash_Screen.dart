import 'package:driving_test_app/color.dart';
import 'package:driving_test_app/home_Screen.dart'; // اطمینان حاصل کنید که این مسیر صحیح است
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(scorePercentage: 0)), // تغییرات لازم در اینجا
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/ground/ground.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    SizedBox(height: 60),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                          TextSpan(
                            text: 'سوالات آزمون آیین نامه رانندگی ',
                          ),
                          TextSpan(text: 'سال 1403'),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Image.asset(
                      'assets/images/logo/logo.png',
                      width: 291,
                      height: 365,
                    ),
                    SizedBox(height: 40),
                    SpinKitWave(
                      size: 30,
                      color: blueSpinKit,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'version 1.1',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

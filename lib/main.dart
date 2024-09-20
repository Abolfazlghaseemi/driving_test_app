import 'package:driving_test_app/color.dart';
import 'package:driving_test_app/splash_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  var application = Application();

  runApp(application);
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge:
              TextStyle(fontFamily: 'yekan', color: whiteText, fontSize: 33),
          titleSmall:
              TextStyle(fontFamily: 'morabba', color: whiteText, fontSize: 18),
          titleMedium:
              TextStyle(fontFamily: 'yekan', color: whiteText, fontSize: 25),
          bodySmall:
              TextStyle(fontFamily: 'yekan', color: whiteText, fontSize: 18),
          labelMedium:
              TextStyle(fontFamily: 'yekan', color: Colors.black, fontSize: 21),
          bodyLarge:
              TextStyle(fontFamily: 'yekan', fontSize: 25, color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

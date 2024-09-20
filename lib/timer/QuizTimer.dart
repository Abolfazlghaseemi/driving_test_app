import 'dart:async';

class QuizTimer {
  final int durationInMinutes;
  late Timer _timer;
  int _remainingSeconds;
  final StreamController<int> _remainingSecondsController =
      StreamController<int>.broadcast();
  final StreamController<bool> _timeUpController =
      StreamController<bool>.broadcast();

  QuizTimer(this.durationInMinutes)
      : _remainingSeconds = durationInMinutes * 60;

  Stream<int> get remainingSecondsStream => _remainingSecondsController.stream;
  Stream<bool> get timeUpStream => _timeUpController.stream;

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        _timer.cancel();
        _timeUpController.add(true);
      } else {
        _remainingSeconds--;
        _remainingSecondsController.add(_remainingSeconds);
      }
    });
  }

  void dispose() {
    _timer.cancel();
    _remainingSecondsController.close();
    _timeUpController.close();
  }
}

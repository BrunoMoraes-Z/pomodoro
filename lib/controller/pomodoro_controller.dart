import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_web/shared/utilities.dart';

enum TimeType { focus, relax }

class PomodoroController extends ChangeNotifier {
  late int focusTime;
  late int breakTime;
  late int currentTime = 0;
  // ignore: avoid_init_to_null
  late Timer? _timer = null;
  late TimeType type = TimeType.focus;

  setFocusTime(int time) {
    focusTime = time;
    if (currentTime < 1) {
      currentTime = focusTime * 60;
    }
    notifyListeners();
  }

  setBreakTime(int time) {
    breakTime = time;
    notifyListeners();
  }

  bool get isRunning => _timer != null;

  cancel() {
    if (isRunning) {
      _timer!.cancel();
      if (type == TimeType.focus) {
        playSound('assets/long_break_end.m4a');
      } else {
        playSound('assets/short_break_end.m4a');
      }
      _timer = null;
    }
    notifyListeners();
  }

  reset() {
    if (type == TimeType.relax) {
      currentTime = breakTime * 60;
    } else {
      currentTime = focusTime * 60;
    }
    notifyListeners();
  }

  startTime() {
    if (currentTime < 1) {
      currentTime = focusTime * 60;
    }
    playSound('assets/sounds_start.m4a');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      --currentTime;

      // Restart Timer
      if (currentTime < 0 && type == TimeType.focus) {
        playSound('assets/short_break_start.m4a');
        type = TimeType.relax;
        currentTime = breakTime * 60;
      } else if (currentTime < 0 && type == TimeType.relax) {
        playSound('assets/sounds_start.m4a');
        type = TimeType.focus;
        currentTime = focusTime * 60;
      }
      notifyListeners();
    });
  }

  String getMinutes() {
    return (currentTime ~/ 60).toString().padLeft(2, '0');
  }

  String getSeconds() {
    return (currentTime % 60).toString().padLeft(2, '0');
  }
}

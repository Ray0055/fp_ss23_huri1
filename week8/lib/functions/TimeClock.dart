import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/providers/providers.dart';
import 'package:week8/functions/DatabaseHelper.dart';

class TimeClock extends ChangeNotifier {
  bool isRunning = false;
  Timer? _timer;
  int _duration = 0;
  List<int> timeStamp = [];

  int get duration {
    return _duration;
  }

  void setDuration(int duration){
    this._duration = duration;
  }

  void startTimer() {
    if (!isRunning) {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        _duration++;
        notifyListeners();
      });
      isRunning = true;
    }
  }

  void stopTimer() {
    if (isRunning) {
      _timer?.cancel();
      isRunning = false;
      notifyListeners();
    }
  }

  void resetTimer(WidgetRef ref) {
    _timer?.cancel();
    timeStamp.add(duration);
    _duration = 0;
    saveToDatabase(ref);
    isRunning = false;
    notifyListeners();
  }

  void saveToDatabase(WidgetRef ref) async{
    Result result = await ref.watch(databaseProvider).getResult();
    result = Result(numberOfThrows: result.numberOfThrows, equalDistr: result.equalDistr , timer: timeStamp.last, numberOfDice1: result.numberOfDice1, numberOfDice2:result.numberOfDice2);
    ref.watch(databaseProvider).insertResult(result);
  }

  String getMaximum() {
    List stamp = timeStamp;
    int max = 0;
    if (stamp.isEmpty) {
      return transformTimer(0);
    } else {
      for (int i = 0; i < stamp.length; i++) {
        if (stamp[i] > max) {
          max = stamp[i];
        }
      }
      return transformTimer(max);
    }
  }

  String getMinimum() {
    List stamp = timeStamp;

    if (stamp.isEmpty) {
      return transformTimer(0);
    } else {
      int min = 1000000;
      for (int i = 0; i < stamp.length; i++) {
        if (stamp[i] < min) {
          min = stamp[i];
        }
      }
      return transformTimer(min.toInt());
    }
  }

  String transformTimer(int milliseconds) {
    int seconds = milliseconds ~/ 10;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    int millisecond = milliseconds % 10;
    return reformTimer(minute) +
        ":" +
        reformTimer(second) +
        "." +
        millisecond.toString();
  }

  String reformTimer(int time) {
    return time < 10 ? "0" + time.toString() : time.toString();
  }
}

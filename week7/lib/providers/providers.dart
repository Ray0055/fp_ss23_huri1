import 'package:week7/functions/Dice.dart';
import 'package:week7/functions/Movie.dart';
import 'package:week7/functions/time_clock.dart';
import 'package:week7/functions/DatabaseHelper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final diceProvider = ChangeNotifierProvider((ref) => Dice(1, 6));
final bottomBarProvider = ChangeNotifierProvider((ref) => bottomBar());
final statisticsIndexProvider =
    ChangeNotifierProvider((ref) => selectedIndex());
final timerProvider = ChangeNotifierProvider((ref) => TimeClock());
final movieProvider = ChangeNotifierProvider((ref) => Movie());
final databaseProvider = ChangeNotifierProvider((ref) => DatabaseHelper());
final numberProvider = StateProvider((ref) => Result(numberOfThrows: 5));
class bottomBar extends ChangeNotifier {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class selectedIndex extends ChangeNotifier {
  int sumStatisticsIndex = 0;
  List diceStatisticsIndex = [0, 0];

  void sumStatistics(int index) {
    sumStatisticsIndex = index + 2;
    notifyListeners();
  }

  void dieStatistics(row, col) {
    diceStatisticsIndex = [row + 1, col + 1];
    notifyListeners();
  }
}

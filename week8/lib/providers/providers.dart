import 'package:week8/functions/DatabaseHelper.dart';
import 'package:week8/functions/Dice.dart';
import 'package:week8/functions/Movie.dart';
import 'package:week8/functions/TimeClock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

final diceProvider = ChangeNotifierProvider((ref) => Dice(1, 6));
final bottomBarProvider = ChangeNotifierProvider((ref) => bottomBar());
final statisticsIndexProvider =
    ChangeNotifierProvider((ref) => selectedIndex());
final timerProvider = ChangeNotifierProvider((ref) => TimeClock());
final movieProvider = ChangeNotifierProvider((ref) => Movie());
final databaseProvider = ChangeNotifierProvider((ref) => DatabaseHelper());
final numberProvider = StateProvider((ref) => 5);

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

void saveToDatabase(WidgetRef ref) async {
  Result result = await ref.watch(databaseProvider).getResult();
  int sumThrows = ref.read(diceProvider).sumThrows;
  int equalDistr = ref.read(diceProvider).eqaulDistr == true ? 1 : 0;
  int timer = ref.read(timerProvider).duration;
  int diceNumber1 = ref.read(diceProvider).diceNumber1;
  int diceNumber2 = ref.read(diceProvider).diceNumber2;
  String sumStatistics = jsonEncode(ref.read(diceProvider).sumStatistics);
  String dieStatistics = jsonEncode(ref.read(diceProvider).dieStatistics);
  // String url = jsonEncode(ref.read(movieProvider).list);
  String url = 'url';
  result = Result(
      numberOfThrows: sumThrows,
      equalDistr: equalDistr,
      timer: timer,
      numberOfDice1: diceNumber1,
      numberOfDice2: diceNumber2,
      sumStatistics: sumStatistics,
      dieStatistics: dieStatistics,
      url: url);
  await ref.read(databaseProvider).insertResult(result);
}

void getFromDatabase(Result result, Dice dice, TimeClock timer) {
  dice.sumThrows = result.numberOfThrows;
  dice.eqaulDistr = result.equalDistr == 1 ? true : false;
  dice.diceNumber1 = result.numberOfDice1;
  dice.diceNumber2 = result.numberOfDice2;
  dice.sumStatistics = List<int>.from(jsonDecode(result.sumStatistics));
  dice.dieStatistics = (jsonDecode(result.dieStatistics) as List)
      .map((e) => List<int>.from(e))
      .toList();
  timer.setDuration(result.timer);
}

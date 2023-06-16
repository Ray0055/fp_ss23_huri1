import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/providers/providers.dart';

class DatabaseHelper extends ChangeNotifier {
  Future<Database> getDatabase() async {
    final db = openDatabase(join(await getDatabasesPath(), 'result.db'));
    return db;
  }

  Future<void> insertResult(Result result) async {
    final db = await getDatabase();
    await db.insert('result', result.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Result> getResult() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('result');
      return Result(
          numberOfThrows: maps.last['numberOfThrows'],
          equalDistr: maps.last['equalDistr'],
          numberOfDice1: maps.last['numberOfDice1'],
          numberOfDice2: maps.last['numberOfDice2'],
          timer: maps.last['timer']
      );
  }

  void writeFromDatabase(WidgetRef ref) async{
    Result result = await ref.watch(databaseProvider).getResult();
    ref.watch(diceProvider).sumThrows = result.numberOfThrows;
    ref.watch(diceProvider).diceNumber1 = result.numberOfDice1;
    ref.watch(diceProvider).diceNumber2 = result.numberOfDice2;
    ref.watch(diceProvider).eqaulDistr =( result.equalDistr==1 ?true:false);
    ref.watch(timerProvider).setDuration(result.timer);
  }
  
}

class Result extends ChangeNotifier {
  int numberOfThrows;
  int equalDistr;
  int timer;
  int numberOfDice1;
  int numberOfDice2;

  Result(
      {required this.numberOfThrows,
      required this.equalDistr,
      required this.timer,
      required this.numberOfDice1,
      required this.numberOfDice2});

  Map<String, Object> toMap() {
    return {
      'numberOfThrows': numberOfThrows,
      'equalDistr': equalDistr,
      'timer': timer,
      'numberOfDice1': numberOfDice1,
      'numberOfDice2': numberOfDice2
    };
  }

  @override
  String toString() {
    return 'Result: number:$numberOfThrows';
  }
}

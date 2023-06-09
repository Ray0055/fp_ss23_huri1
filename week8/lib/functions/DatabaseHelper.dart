import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

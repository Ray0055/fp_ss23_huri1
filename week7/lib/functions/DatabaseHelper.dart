import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:week7/functions/Dice.dart';

class DatabaseHelper extends ChangeNotifier{
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//       join(await getDatabasesPath(), 'doggie_database.db'),
//   // When the database is first created, create a table to store dogs.
//       onCreate: (db, version) {
//   // Run the CREATE TABLE statement on the database.
//   return db.execute(
//   'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
//   );
// },
// // Set the version. This executes the onCreate function and provides a
// // path to perform database upgrades and downgrades.
// version: 1,
// );
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<void> createItems(Result result) async {
    final Database db = await initializeDB();
    final id = await db.insert('Result', result.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Result>> getItems() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult =
    await db.query('Result');
    return List.generate(queryResult.length, (i) {
      return Result(
        numberOfThrows: queryResult[i]['numberOfThrows'],
      );
    });
  }
}





class Result extends ChangeNotifier{
  int numberOfThrows;

  Result({required this.numberOfThrows});

  Map<String, Object> toMap() {
    return {'numberOfThrows': numberOfThrows};
  }}

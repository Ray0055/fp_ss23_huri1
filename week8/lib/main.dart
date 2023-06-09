import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/functions/Router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'result.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE result('
            'numberOfThrows INTEGER, '
            'timer INTEGER, '
            'numberOfDice1 INTEGER,'
            'numberOfDice2 INTEGER,'
            'equalDistr INTEGER)',
      );
    },
    version: 1,
  );

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router_config,
    );
  }
}

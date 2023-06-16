import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/functions/Dice.dart';
import 'package:week8/functions/Router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:week8/functions/TimeClock.dart';
import 'package:week8/providers/providers.dart';
import 'package:week8/functions/DatabaseHelper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  
  final container = ProviderContainer();

  Result result = await container.read(databaseProvider).getResult();
  Dice dice = Dice(1, 6);
  TimeClock timer = TimeClock();

  getFromDatabase(result, dice, timer);
  runApp(ProviderScope(
    overrides: [
      diceProvider.overrideWith((ref) => dice),
      timerProvider.overrideWith((ref) => timer)
    ],
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

void writeFromDatabase(WidgetRef ref) async{
    Result result = await ref.watch(databaseProvider).getResult();
    ref.watch(diceProvider).sumThrows = result.numberOfThrows;
    ref.watch(diceProvider).diceNumber1 = result.numberOfDice1;
    ref.watch(diceProvider).diceNumber2 = result.numberOfDice2;
    ref.watch(diceProvider).eqaulDistr =( result.equalDistr==1 ?true:false);
    ref.watch(timerProvider).setDuration(result.timer);
  }

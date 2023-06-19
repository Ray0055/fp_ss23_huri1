import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/functions/Dice.dart';
import 'package:week8/functions/Router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:week8/functions/TimeClock.dart';
import 'package:week8/providers/providers.dart';
import 'package:week8/functions/DatabaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Dice dice = Dice(1, 6);
  TimeClock timer = TimeClock();
  
  final container = ProviderContainer();
  await container.read(databaseProvider).initial();
  await container.read(databaseProvider).checkNull();

  Result result = await container.read(databaseProvider).getResult();
  
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


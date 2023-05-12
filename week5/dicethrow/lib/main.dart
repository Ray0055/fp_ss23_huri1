import 'package:flutter/material.dart';
import 'Dice.dart';
import 'dart:math';
import 'dart:core';

void main() {
  runApp(MyApp());
}

List _sumStatistics = List.generate(11, (index) => 0);
List<List<int>> _dieStatistics = List.generate(6, (_) => List.filled(6, 0));
bool _isSwitched = false;
int diceSum = 0;
int diceNumber1 = 1;
int diceNumber2 = 1;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dice Roller'),
        ),
        body: MyHomePage(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = DicePage();
        break;
      case 1:
        page = StatisticsPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600, // ← Here.
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.casino),
                    label: Text('RollDice'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.assessment),
                    label: Text('Statistics'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                  // color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                  color: Colors.white),
            ),
          ],
        ),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  Dice dice = Dice(1, 6);

  void rollDice() {
    setState(() {
      diceNumber1 = Random().nextInt(6) + 1;
      diceNumber2 = Random().nextInt(6) + 1;
      diceSum++;
      _dieStatistics[diceNumber1 - 1][diceNumber2 - 1] += 1;
      _sumStatistics[diceNumber1 + diceNumber2 - 2] += 1;
    });
  }

  void resetDice() {
    setState(() {
      diceNumber1 = 1;
      diceNumber2 = 1;
      diceSum = 0;
      _sumStatistics = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
      _dieStatistics = List.generate(6, (_) => List.filled(6, 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You rolled:',
                style: TextStyle(fontSize: 24),
              ),
              GestureDetector(
                onTap: rollDice,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/Images/dice$diceNumber1.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      SizedBox(width: 1),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/Images/dice$diceNumber2.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      )
                    ]),
              ),
              const SizedBox(height: 10),
              Text(
                'You have rolled $diceSum times',
                style: const TextStyle(fontSize: 15),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Same distribution:'),
                const SizedBox(width: 5),
                Switch(
                  value: _isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    dice.throwDice(_isSwitched, 1000);
                    diceSum += 1000;
                    List temp1 = dice.sumStatistics;
                    List<List<int>> temp2 = dice.dieStatistics;
                    _sumStatistics = List.generate(_sumStatistics.length,
                        (index) => _sumStatistics[index] + temp1[index]);
                    setState(() {
                      diceNumber1 = dice.result()[0];
                      diceNumber2 = dice.result()[1];
                    });

                    for (int i = 0; i < 6; i++) {
                      for (int j = 0; j < 6; j++) {
                        _dieStatistics[i][j] += temp2[i][j];
                      }
                    }
                  },
                  child: const Text('Roll 1000 times')),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Are you sure to reset?'),
                action: SnackBarAction(
                    label: 'Yes',
                    onPressed: () {
                      resetDice();
                    })));
          },
          tooltip: 'Reset',
          child: const Icon(Icons.restart_alt),
        ));
  }
}

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPage createState() => _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {
  Widget build(BuildContext context) {
    int maxSum = _sumStatistics
        .reduce((value, element) => value > element ? value : element);
    int maxdie = _dieStatistics
        .expand((row) => row)
        .reduce((value, element) => value > element ? value : element);

    return ListView(
      children: [
        const Text(
          'Sum Statistics',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(children: [
            Row(
                children: List.generate(
              11,
              (index) => Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(child: Text('${index + 2}'))),
            )),
            Row(
                children: List.generate(
              11,
              (index) => Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.lerp(Colors.red, Colors.green,
                        _sumStatistics[index] / (maxSum + 1)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(child: Text('${_sumStatistics[index]}'))),
            ))
          ]),
        ),
        const Text(
          'Die Statistics',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        ...List.generate(6, (row) {
          return Expanded(
            child: Row(
              children: List.generate(6, (col) {
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.lerp(Colors.red, Colors.green,
                          _dieStatistics[row][col] / (maxdie + 1)),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Center(
                      child: Text('${_dieStatistics[row][col]}'),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }
}

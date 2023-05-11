import 'package:flutter/material.dart';
import 'Dice.dart';
import 'dart:math';
import 'dart:core';
import 'package:collection/collection.dart';
void main() {
  runApp(MyApp());
}

int a = 0;
void _add() {
  a++;
}

List sum = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dice Roller'),
        ),
        body: MyHomePage(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class Statistics extends ChangeNotifier {}

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
                    icon: Icon(Icons.home),
                    label: Text('RollDice'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
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
  int diceNumber1 = 1;
  int diceNumber2 = 1;
  int diceSum = 0;
  Dice dice = Dice(1, 6);

  void rollDice() {
    setState(() {
      diceNumber1 = Random().nextInt(6) + 1;
      diceNumber2 = Random().nextInt(6) + 1;
      diceSum++;
    });
  }

  void resetDice() {
    setState(() {
      diceNumber1 = 1;
      diceNumber2 = 1;
      diceSum = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
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
                  SizedBox(width: 20),
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
          SizedBox(height: 10),
          SizedBox(height: 20),
          Text(
            'You have rolled $diceSum times',
            style: TextStyle(fontSize: 15),
          ),
          ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Are you sure to reset?'),
                    action: SnackBarAction(
                        label: 'Yes',
                        onPressed: () {
                          resetDice(); // Code to execute.
                        })));
              },
              child: Text('Reset')),
          ElevatedButton(
              onPressed: () {
                dice.throwDice(true, 1000);
                List temp = dice.sumStatistics;
                sum = List.generate(sum.length, (index) => sum[index] + temp[index]);
                _add();
              },
              child: Text('Roll 1000 times'))
        ],
      ),
    );
  }
}

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPage createState() => _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {
  

  Widget build(BuildContext context) {
    List sums = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    sums = sum;
  
    int maxSum = sums.reduce((value, element) => value > element ? value : element);
    return Center(
        child: IntrinsicHeight(
      child: Column(children: [
        ...List.generate(
          11,
          (index) => Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color.lerp(
                    Color.fromARGB(255, 232, 27, 13), Color.fromARGB(255, 34, 180, 39), sum[index] / (maxSum + 1)),
                border: Border.all(color: Colors.black),
              ),
              child: Center(child: Text('${sum[index]}'))),
        ),
      
      Text('$sum')]),
    ));
  }
}

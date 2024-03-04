import 'package:flutter/material.dart';
import 'package:week8/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/screens/DicePage.dart';
import 'package:week8/screens/StatisticsPage.dart';
import 'package:week8/screens/SettingPage.dart';

class HomePage extends ConsumerWidget with WidgetsBindingObserver {
  const HomePage({Key? key}) : super(key: key);

  static List pages = [
    DicePage(),
    StatisticsPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomBarProvider).selectedIndex;

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            label: 'Dice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.restart_alt), label: 'undo')
        ],
        currentIndex: index,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          if (index == 3) {
            if (ref.watch(diceProvider).size < 0) {
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Can\'t undo anymore!'),
                    action:
                        SnackBarAction(label: 'Dismiss', onPressed: () {})));
              }
            } else if (ref.watch(diceProvider).size >= 0) {
              ref.watch(diceProvider).undo();
            }
          } else {
            ref.watch(bottomBarProvider).onItemTapped(index);
          }
        },
      ),
    );
  }
}

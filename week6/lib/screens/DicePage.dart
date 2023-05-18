import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week6/providers/providers.dart';

class DicePage extends ConsumerWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceNumber1 = ref.watch(diceProvider).diceNumber1;
    final diceNumber2 = ref.watch(diceProvider).diceNumber2;
    final dice = ref.watch(diceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Throw'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              dice.throwDice(dice.eqaulDistr, 1);
              ref.read(diceProvider).increment();
            },
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
                  const SizedBox(width: 1),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The total number of throws: ${ref.watch(diceProvider).sumThrows} ',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              Text(
                'The type of distribution: ${ref.watch(diceProvider).eqaulDistr == false ? 'not equal' : 'equal'}',
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40)),
                  onPressed: () {
                    dice.throwDice(dice.eqaulDistr, 1000);
                    dice.increment();
                  },
                  child: const Text('1000')),
            ],
          ),
        ],
      ),
    );
  }
}

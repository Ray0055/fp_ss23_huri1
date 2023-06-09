import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/providers/providers.dart';
import 'package:week8/functions/DatabaseHelper.dart';
class DicePage extends ConsumerWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceNumber1 = ref.watch(diceProvider).diceNumber1;
    final diceNumber2 = ref.watch(diceProvider).diceNumber2;
    final dice = ref.watch(diceProvider);
    final timer = ref.watch(timerProvider);



    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Throw'),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            height: 312,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: FutureBuilder(
                      future: ref.watch(movieProvider).list,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Column(children: [
                            Image.asset(
                                'assets/Images/Cinema-in-the-Power-Station-image001hero-1600x869.jpg'),
                            const Text('Throw dice to get your film!',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                          ]);
                        } else {
                          return Column(
                            children: [
                              Image.network(ref
                                  .watch(movieProvider)
                                  .getUrl(snapshot.data["backdrop_path"])),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${snapshot.data["original_title"]}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  (Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          overflow: TextOverflow.fade,
                                          maxLines: 5,
                                          '${snapshot.data["overview"]}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ))))
                                ],
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              dice.throwDice(dice.eqaulDistr, 1, ref);
              ref.read(diceProvider).increment();
              if (timer.isRunning) {
                timer.stopTimer();
                timer.resetTimer(ref);
                timer.startTimer();
              } else {
                timer.startTimer();
              }
              ref.watch(movieProvider).toFuture();
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
                textAlign: TextAlign.left,
                'The total number of throws: ${ref.watch(diceProvider).sumThrows} ',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              Text(
                'The type of distribution: ${ref.watch(diceProvider).eqaulDistr == false ? 'not equal' : 'equal'}',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              Text(
                'Duration between two throws is ${timer.transformTimer(timer.duration)}',
                style: const TextStyle(fontSize: 15),
              ),
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
                    dice.throwDice(dice.eqaulDistr, 1000, ref);
                    dice.increment();
                    if (timer.isRunning) {
                      timer.stopTimer();
                      timer.resetTimer(ref);
                      timer.startTimer();
                    } else {
                      timer.startTimer();
                    }
                    ref.watch(movieProvider).toFuture();
                  },
                  child: const Text('1000')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40)),
                  onPressed: () {
                    timer.stopTimer();


                  },
                  child: Text("stop timer")),
            ],
          ),


        ],
      )),
    );
  }
}

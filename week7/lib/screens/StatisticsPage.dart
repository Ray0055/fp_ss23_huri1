import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week7/providers/providers.dart';
import 'package:go_router/go_router.dart';

class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final _sumStatistics = ref.watch(diceProvider).sumStatistics;
    final _dieStatistics = ref.watch(diceProvider).dieStatistics;
    int maxSum = _sumStatistics
        .reduce((value, element) => value > element ? value : element);
    int maxdie = _dieStatistics
        .expand((row) => row)
        .reduce((value, element) => value > element ? value : element);

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: ListView(
        shrinkWrap: true,
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
                (index) => GestureDetector(
                  onTap: () {
                    context.pushNamed('sumdetail');
                    ref.watch(statisticsIndexProvider).sumStatistics(index);
                    ref.watch(diceProvider).getMaximum(_sumStatistics);
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.lerp(const Color(0xFFE3F2FD), const Color(0xFF0D47A1),
                            _sumStatistics[index] / (maxSum + 1)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(child: Text('${_sumStatistics[index]}'))),
                ),
              ))
            ]),
          ),
          const Text(
            'Die Statistics',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
            itemCount: 36,
            itemBuilder: (BuildContext context, int index) {
              int row, col;
              row = index % 6;
              col = index ~/ 6;
              return GestureDetector(
                  onTap: () {
                    context.pushNamed('diedetail');
                    ref.watch(statisticsIndexProvider).dieStatistics(row, col);
                    ref.watch(diceProvider).getMaximum(_dieStatistics);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.lerp(
                          const Color(0xFFE3F2FD),
                          const Color(0xFF0D47A1),
                          _dieStatistics[row][col] / (maxdie + 1)),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Center(
                      child: Text('${_dieStatistics[row][col]}'),
                    ),
                  ));
            },
          ),

        ],
      ),
    );
  }
}

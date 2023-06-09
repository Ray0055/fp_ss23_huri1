import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/providers/providers.dart';
import 'package:settings_ui/settings_ui.dart';

class SumDetialPage extends ConsumerWidget {
  const SumDetialPage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(statisticsIndexProvider).sumStatisticsIndex;
    final sumThrows = ref.watch(diceProvider).sumThrows;
    final sumStatistics = ref.watch(diceProvider).sumStatistics;
    final timer = ref.watch(timerProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('Sum Detail')),
        body: SettingsList(sections: [
          SettingsSection(tiles: <SettingsTile>[
            SettingsTile(
              title: Text('Total number of throws: $sumThrows'),
            ),
            SettingsTile(
              title: Text('Chosed sum: $index'),
            ),
            SettingsTile(
              title: Text(
                  'How often this sum was thrown: ${(sumStatistics[index - 2] / sumThrows).toStringAsFixed(2)}'),
            ),
            SettingsTile(
              title: Text(
                  'The maximum sum is: ${ref.watch(diceProvider).maxSum}, which is ${ref.watch(diceProvider).maxSumIndex}'),
            ),
            SettingsTile(
              title: Text('The maximum duration is ${timer.getMaximum()}'),
            ),
            SettingsTile(
              title: Text('The minimum duration is ${timer.getMinimum()}'),
            )
          ])
        ]));
  }
}

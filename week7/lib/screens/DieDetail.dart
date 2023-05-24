import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week6/providers/providers.dart';
import 'package:settings_ui/settings_ui.dart';

class DieDetailPage extends ConsumerWidget {
  const DieDetailPage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(statisticsIndexProvider).diceStatisticsIndex;
    final sumThrows = ref.watch(diceProvider).sumThrows;
    final dieStatistics = ref.watch(diceProvider).dieStatistics;
    final sum = dieStatistics[index[0] - 1][index[1] - 1];
    final prob = dieStatistics[index[0] - 1][index[1] - 1] / sumThrows;
    final timer = ref.watch(timerProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('Die Detail')),
        body: SettingsList(sections: [
          SettingsSection(tiles: <SettingsTile>[
            SettingsTile(
              title: Text(
                  'Total number of throws: ${ref.watch(diceProvider).sumThrows}'),
            ),
            SettingsTile(
              title: Text('Chosed combination: $index'),
            ),
            SettingsTile(
              title: Text('Chosed sum: $sum'),
            ),
            SettingsTile(
              title: Text('How often was thrown: ${prob.toStringAsFixed(3)}'),
            ),
            SettingsTile(
              title: Text(
                  'The maximum combination: ${ref.watch(diceProvider).maxDiceIndex}, ${ref.watch(diceProvider).maxDice}'),
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

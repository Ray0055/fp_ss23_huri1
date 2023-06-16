import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week8/providers/providers.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Common'),
              tiles: <SettingsTile>[
                SettingsTile(
                  title:  Text('Total number of throws: ${ref.watch(diceProvider).sumThrows}'),
                  leading: const Icon(Icons.assessment),
                
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    ref.watch(diceProvider).equalDistribution(value, ref);
                    ref.watch(diceProvider).increment();
                  },
                  leading: const Icon(Icons.balance),
                  initialValue: ref.watch(diceProvider).eqaulDistr,
                  title: const Text('Enable equal distribution'),
                ),
                SettingsTile(
                    title: const Text('Reset',
                        style: TextStyle(color: Colors.blue)),
                    leading: const Icon(Icons.restart_alt),
                    onPressed: (BuildContext context) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Are you sure to reset?'),
                          action: SnackBarAction(
                              label: 'Yes',
                              onPressed: () {
                                ref.watch(diceProvider).resetStatistics();
                                ref.watch(diceProvider).increment();
                                ref.watch(timerProvider).resetTimer(ref);
                                ref.watch(timerProvider).timeStamp = [];
                                saveToDatabase(ref);
                              })));
                    }),
              ],
            ),
          ],
        ));
  }
}

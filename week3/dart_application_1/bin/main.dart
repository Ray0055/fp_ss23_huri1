import 'Dice.dart';
import 'dart:io';

void main() {
  Dice dice = Dice(1, 6);
  stdout.write('Enter numbedarOfThrows: ');
  int num = int.parse(stdin.readLineSync()!);
  dice.throwDice(false, num);
  print("equalDistr = ${dice.eqaulDistr}, numberOfThrows = ${dice.numberOfThrows},sumStatistics = ${dice.sumStatistics}");
  dice.resetStatistics();
  dice.throwDice(true, num);
  print("equalDistr = ${dice.eqaulDistr}, numberOfThrows = ${dice.numberOfThrows},sumStatistics = ${dice.sumStatistics}");

}

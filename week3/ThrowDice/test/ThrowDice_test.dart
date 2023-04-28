import '../bin/Dice.dart';

void main() {
  Dice dice = Dice(1, 6);
  dice.throwDice(false, 2);
  print("equalDistr = ${dice.eqaulDistr}, numberOfThrows = ${dice.numberOfThrows},sumStatistics = ${dice.sumStatistics}");
}

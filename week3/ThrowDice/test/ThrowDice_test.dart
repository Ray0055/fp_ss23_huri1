import '../bin/Dice.dart';

void main() {
  Dice dice = Dice(1, 6);
  dice.throwDice(false, 5000);
  print(
      "equalDistr = ${dice.eqaulDistr}, numberOfThrows = ${dice.numberOfThrows},sumStatistics = ${dice.sumStatistics}, \n ");

  for (int i = 0; i < 6; i++) {
    print(dice.dieStatistics[i]);
  }

  List sum = dice.dieStatistics.reduce((a, b) => a+b);
  int sum1 = sum.reduce((value, element) => value + element);
  print(sum1);
}

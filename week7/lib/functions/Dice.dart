import 'dart:math';
import 'package:flutter/material.dart';

class Dice extends ChangeNotifier {
  bool eqaulDistr = false;
  List<int> die = [0, 0];
  int numberOfThrows = 0;
  int minDie = 1;
  int maxDie = 6;
  int rangeOfDie = 5;
  int rangeOfSum = 11;
  List<int> sumStatistics = [];
  List<List<int>> dieStatistics = List.generate(6, (_) => List.filled(6, 0));
  int diceNumber1 = 1;
  int diceNumber2 = 1;
  int sumThrows = 0;

  int maxSum = 0;
  int maxSumIndex = 0;
  int maxDice = 0;
  List<int> maxDiceIndex = [0, 0];

  Dice(int minDie, int maxDie) {
    this.minDie = minDie;
    this.maxDie = maxDie;
    this.rangeOfDie = maxDie - minDie + 1;
    this.rangeOfSum = 2 * (maxDie - minDie) + 1;
    sumStatistics = List.generate(rangeOfSum, (_) => 0);
    List<List<int>> dieStatistics = List.generate(
        maxDie - minDie + 1, (_) => List.filled(maxDie - minDie + 1, 0));
  }

  void throwDice(bool eqaulDistr, int numberOfThrows) {
    sumThrows += numberOfThrows;
    this.numberOfThrows = numberOfThrows;
    this.eqaulDistr = eqaulDistr;
    Random random = Random();
    if (!eqaulDistr) {
      Random random = Random();
      //create n times rolls
      final dice1 =
          List.generate(numberOfThrows, (_) => random.nextInt(rangeOfDie));
      final dice2 =
          List.generate(numberOfThrows, (_) => random.nextInt(rangeOfDie));
      for (int i = 0; i < numberOfThrows; i++) {
        dieStatistics[dice1[i]][dice2[i]]++;
        sumStatistics[dice1[i] + dice2[i]]++;
      }
    }
    /*
    My idea is to randomly select an element on a diagonal of the two-dimensional matrix dieStatistics, 
    where elements on the same anti-diagonal have the same sum of row and column indices. For example, 
    (2,4) and (4,2) are on the same anti-diagonal with a sum of row and column indices of 3. Therefore, 
    we can first randomly choose a diagonal and then randomly choose an element on that diagonal, achieving 
    equal probability of rolling dice.
    */
    else {
      final random2 = Random();
      final random3 = Random();
      final dice = List.generate(2 * (maxDie - minDie) - 1, (index) => 0);
      for (int i = 0; i < numberOfThrows; i++) {
        int choosedSum = random2.nextInt(rangeOfSum);
        sumStatistics[choosedSum]++;

        int matrixSize = maxDie - minDie + 1; // size of matrix
        int diagonalIndex = choosedSum; // from 0 to 2*maxDie - 1
        int maxDiagonaIndex = rangeOfSum;
        int row, col;

        if (diagonalIndex < matrixSize) {
          row = random3.nextInt(diagonalIndex + 1);
          col = diagonalIndex - row;
        } else {
          row = random3.nextInt(maxDiagonaIndex - diagonalIndex) +
              matrixSize -
              (maxDiagonaIndex - diagonalIndex);
          col = diagonalIndex - row;
        }
        dieStatistics[row][col]++;
      }
    }
    diceNumber1 = random.nextInt(6) + 1;
    diceNumber2 = random.nextInt(6) + 1;
    notifyListeners();
  }

  void resetStatistics() {
    this.sumStatistics = List.generate(rangeOfSum, (_) => 0);
    this.dieStatistics = List.generate(
        maxDie - minDie + 1, (_) => List.filled(maxDie - minDie + 1, 0));
    diceNumber1 = 1;
    diceNumber2 = 1;
    sumThrows = 0;
    notifyListeners();
  }

  void throwDiceOnce() {
    Random random = Random();
    diceNumber1 = random.nextInt(6) + 1;
    diceNumber2 = random.nextInt(6) + 1;
    sumThrows += 1;
    notifyListeners();
  }

  void equalDistribution(bool value) {
    eqaulDistr = value;
    notifyListeners();
  }

  void getMaximum(statistics) {
    if (statistics[0] is List) {
      for (int i = 0; i < statistics.length; i++) {
        for (int j = 0; j < statistics[i].length; j++) {
          if (statistics[i][j] > maxDice) {
            maxDice = statistics[i][j];
            maxDiceIndex = [i + 1, j + 1];
          }
        }
      }
    } else {
      for (int i = 0; i < statistics.length; i++) {
        if (statistics[i] > maxSum) {
          maxSum = statistics[i];
          maxSumIndex = i + 2;
        }
      }
    }
  }

  List _historyDieStatistics = [];
  List _historySumStatistics = [];
  List _historySumThrows = [];
  List _historyDistribution = [];
  int size = 0;

  void increment() {
    size++;
    _historySumThrows.add(sumThrows);
    _historyDistribution.add(eqaulDistr);
    _historyDieStatistics.add(
        dieStatistics.map<List<int>>((lst) => List<int>.from(lst)).toList());
    _historySumStatistics.add(List<int>.from(sumStatistics.cast<int>()));
    notifyListeners();
  }

  void undo() {
    size--;
    _historySumThrows.removeLast();
    _historyDistribution.removeLast();
    _historyDieStatistics.removeLast();
    _historySumStatistics.removeLast();
    if (size == 0) {
      sumThrows = 0;
      dieStatistics = List.generate(6, (_) => List.filled(6, 0));
      sumStatistics = List.generate(11, (index) => 0);
      eqaulDistr = false;
    } else if (size < 0) {
      sumThrows = 0;
      dieStatistics = List.generate(6, (_) => List.filled(6, 0));
      sumStatistics = List.generate(11, (index) => 0);
    } else {
      sumThrows = _historySumThrows.last;
      eqaulDistr = _historyDistribution.last;
      dieStatistics = _historyDieStatistics.last;
      sumStatistics = _historySumStatistics.last;
    }
    notifyListeners();
  }
}

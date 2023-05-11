import 'dart:math';

class Dice {
  bool eqaulDistr = true;
  List<int> die = [0, 0];
  int numberOfThrows = 0;
  int minDie = 1;
  int maxDie = 6;
  int rangeOfDie = 5;
  int rangeOfSum = 11;
  List sumStatistics = [];
  List<List<int>> dieStatistics = List.generate(6, (_) => List.filled(6, 0));

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
    this.numberOfThrows = numberOfThrows;
    this.eqaulDistr = eqaulDistr;
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
          row = random3.nextInt(maxDiagonaIndex - diagonalIndex) + matrixSize-(maxDiagonaIndex - diagonalIndex);
          col = diagonalIndex - row;
        }
        dieStatistics[row][col]++;
      }
    }
  }

  void resetStatistics() {
    this.sumStatistics = List.generate(rangeOfSum, (_) => 0);
    this.dieStatistics = List.generate(
        maxDie - minDie + 1, (_) => List.filled(maxDie - minDie + 1, 0));

  }

  List result(){
    Random random = Random();
    List dice = List.generate(2, (_) => random.nextInt(6) + 1);
    return dice;
  }
}

import 'dart:math';

import 'package:dart_application_1/dart_application_1.dart';
import 'package:test/test.dart';

void main() {
  int maxDie = 3;
  int minDie = 1;
  int choosedSum = 3;
  int matrixSize = maxDie - minDie + 1; // 方阵的大小
  int diagonalIndex = choosedSum; // 对角线索引
  int row, col;
  Random random3 = Random();
  col = random3.nextInt((matrixSize) - (diagonalIndex - matrixSize / 2 - 1).ceil()) +
        (diagonalIndex - matrixSize / 2 - 1).ceil() ;
  print(col);
  print((matrixSize) - (diagonalIndex - matrixSize / 2 - 1).ceil());
}

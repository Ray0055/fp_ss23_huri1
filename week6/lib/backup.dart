void main() {


int maxSum = 0;
int maxSumIndex = 0;
void getMaximum(statistics) {
    if (statistics[0] is List) {
      
    } else {
      maxSum = statistics
          .reduce((value, element) => value > element ? value : element);
      maxSumIndex = statistics.indexOf(maxSum) + 2 * 1;
    }
  }

  getMaximum([1,2,3]);
  print(maxSum);
}
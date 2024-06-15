void main() {
  void printResult(int a, int b, Function operation) {
    int result = operation(a, b);
    print(result);
  }

  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;

  printResult(10, 5, add); 
  printResult(10, 5, subtract); 


  Function multiplyBy(int factor) {
    return (int value) => value * factor;
  }

  var multiplyBy2 = multiplyBy(2);
  print(multiplyBy2(5)); 

  var multiplyBy3 = multiplyBy(3);
  print(multiplyBy3(5)); 

  printResult(10, 5, (a, b) => a * b); 
}

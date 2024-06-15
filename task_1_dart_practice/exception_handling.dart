void main() {
  try {
    int result = 10 ~/ 0; 
    print(result);
  } catch (e) {
    print("Error: $e");
  } finally {
    print("This is always executed");
  }

  try {
    List<int> numbers = [1, 2, 3];
    print(numbers[5]); 
  } on RangeError catch (e) {
    print("RangeError: $e");
  } catch (e) {
    print("Other Error: $e");
  }

  try {
    checkAge(15);
  } catch (e) {
    print("Caught an exception: $e");
  }
}

void checkAge(int age) {
  if (age < 18) {
    throw Exception("Age must be at least 18.");
  }
  print("Age is valid.");
}

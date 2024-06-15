void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  numbers.add(6);
  print(numbers); 

  List<dynamic> mixedList = [1, "two", 3.0];
  print(mixedList); 

  List<String> fruits = [];
  fruits.add("Apple");
  fruits.addAll(["Banana", "Cherry"]);
  print(fruits);

  List<int> moreNumbers = [7, 8, ...numbers];
  print(moreNumbers); 

  List<int?> nullableNumbers = [1, 2, null, 4];
  print(nullableNumbers); 
}

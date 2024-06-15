void main() {
  for (int i = 0; i < 5; i++) {
    print(i);
  }

  int i = 0;
  while (i < 5) {
    print(i);
    i++;
  }

  List<String> fruits = ["Apple", "Banana", "Cherry"];
  for (String fruit in fruits) {
    print(fruit);
  }

  int j = 0;
  do {
    print("Do-While: $j");
    j++;
  } while (j < 5);

  for (int k = 0; k < fruits.length; k++) {
    print("Fruit at index $k: ${fruits[k]}");
  }

  for (int m = 0; m < 10; m++) {
    if (m == 5) break;
    if (m % 2 == 0) continue;
    print(m);
  }
}

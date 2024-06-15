void main() {
  int age = 18;

  if (age >= 18) {
    print("Adult");
  } else {
    print("child");
  }

  String result = age >= 18 ? "Adult" : "child";
  print(result);

  int score = 85;
  if (score >= 90) {
    print("Grade: A");
  } else if (score >= 80) {
    print("Grade: B");
  } else if (score >= 70) {
    print("Grade: C");
  } else {
    print("Grade: F");
  }

  String weather = "sunny";
  switch (weather) {
    case "sunny":
      print("It's a sunny day!");
      break;
    case "rainy":
      print("Take an umbrella.");
      break;
    case "cloudy":
      print("It might rain later.");
      break;
    default:
      print("Unknown weather.");
  }
}

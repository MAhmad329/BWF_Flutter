import 'dart:async';

void main() async {
  Stream<int> numberStream = Stream<int>.periodic(
    Duration(seconds: 1),
    (x) => x,
  ).take(5);

  await for (int number in numberStream) {
    print(number);
  }

  Stream<String> colorStream = Stream.fromIterable(["Red", "Green", "Blue"]);
  await for (String color in colorStream) {
    print(color);
  }


  StreamController<int> controller = StreamController<int>();
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  await for (int number in controller.stream) {
    print("Controller Stream: $number");
  }
  await controller.close();
}

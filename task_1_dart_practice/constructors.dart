void main() {
  Car car = Car("Toyota", "Grande", 2021);
  car.displayInfo();

  Car oldCar = Car.oldCar("Honda", "City");
  oldCar.displayInfo();

  Car newCar = Car.newModel("Kia");
  newCar.displayInfo();
}

class Car {
  String brand;
  String model;
  int year;

  Car(this.brand, this.model, this.year);

  // Named constructor
  Car.oldCar(this.brand, this.model) : year = 1920;

  // Redirecting constructor
  Car.newModel(String brand) : this(brand, "Latest Model", 2024);

  void displayInfo() {
    print("Brand: $brand, Model: $model, Year: $year");
  }
}

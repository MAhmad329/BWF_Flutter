class Person {
  String name;
  int age;

  Person(this.name, this.age);

  Person.withAge(this.name, this.age);

  factory Person.unknown() {
    return Person("Unknown", 0);
  }

  void displayInfo() {
    print("Name: $name, Age: $age");
  }
}

void main() {
  Person person = Person("Muhammad Ahmad", 23);
  person.displayInfo();

  Person olderPerson = Person.withAge("Anfaal Afrose", 30);
  olderPerson.displayInfo();

  Person unknownPerson = Person.unknown();
  unknownPerson.displayInfo();
}

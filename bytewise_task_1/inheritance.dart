class Animal {
  void makeSound() {
    print("Animal makes a sound");
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print("Dog barks");
  }
}

class Bird extends Animal {
  @override
  void makeSound() {
    super.makeSound();
    print("Bird chirps");
  }
}

class Poodle extends Dog {
  @override
  void makeSound() {
    print("Poodle barks softly");
  }
}

void main() {
  Dog dog = Dog();
  dog.makeSound();

  Bird bird = Bird();
  bird.makeSound();

  Poodle poodle = Poodle();
  poodle.makeSound();
}

abstract class Shape {
  void draw();
  double getArea();
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);

  @override
  void draw() {
    print("Drawing Circle");
  }

  @override
  double getArea() {
    return 3.14 * radius * radius;
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  void draw() {
    print("Drawing Rectangle");
  }

  @override
  double getArea() {
    return width * height;
  }
}

void main() {
  Circle circle = Circle(5.0);
  circle.draw(); 
  print("Area: ${circle.getArea()}"); 

  Rectangle rectangle = Rectangle(4.0, 5.0);
  rectangle.draw(); 
  print("Area: ${rectangle.getArea()}"); 
}

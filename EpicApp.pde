

Bolla Prueva;

void setup() {
  size(480, 800);
  Prueva = new Bolla(100, 100, 10, 10);
}

void draw() {

  background(255);
  Prueva.Mover();
  Prueva.Mostar();
}

void mousePressed() {
  Prueva = new Bolla(mouseX, mouseY, -1, -10);
}


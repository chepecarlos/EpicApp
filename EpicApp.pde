
Bolla Prueva;
int Limite;

void setup() {
  size(480, 800);
  Prueva = new Bolla(100, 100, 10, 10);
  Limite = (3*height)/4;
}

void draw() {

  background(255);
  Prueva.Mover();
  Prueva.Mostar();
  line(0, Limite, width, Limite);
  ellipse(width/2, Limite, 10, 10);
}

void mousePressed() {
  if ( mouseY > Limite) {
    Prueva = new Bolla(mouseX, mouseY, -1, -10);
  }
}



Bolla Prueva;
int Limite;
int PXi, PYi;
int PXf, PYf;
int AchoAtaque;

void setup() {
  size(480, 800);
  Prueva = new Bolla(100, 100, 10, 10);
  Limite = (3*height)/4;
  AchoAtaque = 100;
}

void draw() {

  background(255);
  Prueva.Mover();
  Prueva.Mostar();
  line(0, Limite, width, Limite);
  ellipse(width/2, Limite, 10, 10);
  MAtaque();
}

void mousePressed() {
  if ( mouseY > Limite) {
    PXi = mouseX;
    PYi = mouseY;
    PXf = PXi;
    PYf = PYi;
  }
}

void mouseReleased() {
  if ( mouseY > Limite) {
    Prueva = new Bolla(mouseX, mouseY, -1, -10);
    PXi = 0;
    PYi = 0;
  }
}

void mouseDragged() {
  if ( (PXi != 0 || PYi != 0)  & mouseY > PYi) {
    PXf = mouseX;
    PYf = mouseY;
  }
}

void MAtaque() {
  if ( PXi != 0 || PYi != 0) {

    ellipseMode(CENTER);
    noFill();
    arc(PXi, PYi, AchoAtaque, AchoAtaque, 0, PI);
    fill(200);
    line(PXi,PYi,PXf,PYf);
    
  }
}


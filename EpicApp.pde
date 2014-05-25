
Bolla Prueva;
int Limite;
int PXi, PYi;
int PXf, PYf;
int AchoAtaque;

void setup() {
  size(480, 800);
  Prueva = new Bolla(100, 100, 10, 10);
  Limite = (3*height)/4;
  AchoAtaque = 200;
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
    float Theta = 0;
    float V =  dist( PXf, PYf, PXi, PYi)/(AchoAtaque/2);
    if ( V > 0.99)  V = 1;
    else if ( V < 0.20) V = 0.20;

    if ( abs(PYi-PYf) != 0) {
      float T1= PXi-PXf; 
      float T2= PYi-PYf;
      float T3 = T1/T2;
      float T4 = atan(T3);
      Theta = T4;
    }



    Prueva = new Bolla(PXi, PYi, -V, Theta);
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
    line(PXi, PYi, PXf, PYf);
  }
}


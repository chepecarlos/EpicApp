
ArrayList<Bolla> Proyectiles;
ArrayList<MalaBolla> Malos;
int Limite;
int PXi, PYi;
int PXf, PYf;
int AchoAtaque;
int Barra;
int Puntos;
int Vida;
void setup() {
  size(480, 800);
  Barra = 30;
  Vida = 100;
  Puntos = 0;
  textSize(Barra);
  Limite = (3*height)/4;
  AchoAtaque = 200;
  Proyectiles = new ArrayList<Bolla>();
  Mallos = new ArrayList<MalaBolla>();
  //Malo = new MalaBolla( 200, 1, 0.20, 0);
}

void draw() {

  background(255);
  line(0, Limite, width, Limite);
  ellipse(width/2, Limite, 10, 10);
  MAtaque();
  ActualizarProyectiles();
  ActualizarMalos();
  Puntos();
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


    Proyectiles.add( new Bolla(PXi, PYi, -V, Theta));
    Puntos++;
    Vida--;
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

void Puntos() {
  fill(0);
  rect(0, 0, width, Barra );
  fill(255);
  text("Puntos "+Puntos, 0, Barra );
  fill(255);
  rect(width/2-5, 5, Vida*width/(200)-5, Barra-10);
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

void  ActualizarProyectiles() {
  for ( int i = Proyectiles.size()-1 ; i >= 0; i--) {
    Bolla MiniProyectil = Proyectiles.get(i);
    MiniProyectil.Mover();
    MiniProyectil.Mostar();
    if (MiniProyectil.SigeViva()) {
      Vida++;
      Proyectiles.remove(i);
    }
  }
}

void  ActualizarMalos() {
  for ( int i = Malo.size()-1 ; i >= 0; i--) {
    Bolla MiniMalo = Malo.get(i);
    MiniMalo.Mover();
    MiniMalo.Mostar();
    IntList Muertos = MiniMalo.Choque(Proyectiles);
    for ( int i = Muertos.size()-1 ; i >= 0; i--) {
      Puntos += 10;
      Proyectiles.remove(Muertos.get(i));
    }
  }
}


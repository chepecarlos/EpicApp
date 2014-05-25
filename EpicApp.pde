
ArrayList<Bolla> Proyectiles;
ArrayList<MalaBolla> Malos;
int Limite;
int PXi, PYi;
int PXf, PYf;
int AchoAtaque;
int Barra;
int Puntos;
int Vida;
int Estado;
int Nivel;

void setup() {
  //Tamaño de la aplicacion
  size(480, 800);

  //Bariables Globales
  Estado = 0;
  Barra = 30;
  Vida = 100;
  Puntos = 0;
  Limite = (3*height)/4;
  AchoAtaque = 200;
  Nivel = 0;

  //Configuraciones  
  textSize(Barra);

  //Areglos con objetos del juego
  Proyectiles = new ArrayList<Bolla>();
  Malos = new ArrayList<MalaBolla>();
}

void draw() {
  switch(Estado)
  {
  case 0:
    println("Intro");
    Estado = 1;
    break;
  case 1:
    println("Menu");
    Estado = 2;
    Nivel = 1;
    break;
  case 2:
    println("Jugando");
    Jugar();
    break;
  case 3:
    println("Perdiste");
    Estado = 1;
    break;
  default: 
    Estado = 0;
    break;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//Funciones con el mouse 
///////////////////////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////
// Funciones del juego 
////////////////////////////////////////////////////////////////////////////////

void Jugar() {
  background(255);
 
  MAtaque();
  ActualizarProyectiles();
  ActualizarMalos();
  Divicion();
  Puntos();
}

void Divicion() {
  line(0, Limite, width, Limite);
  fill(255);
  ellipse(width/2, Limite, Barra,Barra);
  fill(0);
  textAlign(CENTER,CENTER);
  text(Nivel, width/2, Limite-5);
}

void Puntos() {
  fill(0);
  rect(0, 0, width, Barra );
  fill(255);
  textAlign( LEFT);
  text("Puntos "+Puntos, 0, Barra );
  fill(255);
  rect(width/2-5, 5, Vida*width/(200)-5, Barra-10);
  if (Vida < 1) Estado = 3;
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
  for ( int i = Malos.size()-1 ; i >= 0; i--) {
    MalaBolla MiniMalo = Malos.get(i);
    MiniMalo.Mover();
    MiniMalo.Mostar();
    IntList Muertos = MiniMalo.Choque(Proyectiles);
    for ( int j = Muertos.size()-1 ; j >= 0; j--) {
      Puntos += 10;
      Vida += MiniMalo.Creditos;
      Proyectiles.remove(Muertos.get(j));
    }
  }
}


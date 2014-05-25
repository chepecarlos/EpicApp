
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
int Reset;

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
    Menu();
    Estado = 2;
    break;
  case 2:
    println("Jugando");
    Jugar();
    Reset = millis();
    break;
  case 3:
    println("Perdiste");
    GameOver();
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
  ellipse(width/2, Limite, Barra, Barra);
  fill(0);
  textAlign(CENTER, CENTER);
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
      Proyectiles.remove(Muertos.get(j));
    }

    if (MiniMalo.SigeViva()) {
      Vida += MiniMalo.Creditos;
      if ( Vida > 100) Vida = 100;
      Malos.remove(i);
    }

    if ( MiniMalo.Ataque()) {
      Vida -= MiniMalo.Golpe;
      Malos.remove(i);
    }
  }
  if ( Malos.size() < 5) {
    Invocar();
  }
}

void Invocar() {
  print("Invocando");
  for ( int i = 0; i < Nivel*5; i++) {
    Malos.add( new MalaBolla( random(100, width-100), -random(height), random(0.10, 0.20), random(-PI/4, PI/4)));
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Pastalla de Game Over
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void GameOver() {

  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Perdiste", width/2, height/2);
  text("\""+Puntos+"\"",  width/2, height/2 + 2*Barra);
  Proyectiles = new ArrayList<Bolla>();
  Malos = new ArrayList<MalaBolla>();
  if ( millis() - Reset > 3000) Estado = 1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Menu de la aplicacion
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Menu() {
  Proyectiles = new ArrayList<Bolla>();
  Malos = new ArrayList<MalaBolla>();
  Vida = 100;
  Puntos = 0;
  Nivel = 1;
}


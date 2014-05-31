// Importando librerias
import ketai.data.*;// Libreria de lite
import android.content.Context;
import android.os.Vibrator;

// Areglos dinamicos 
ArrayList<Bolla> Proyectiles;
ArrayList<MalaBolla> Malos;

// Variables Globales
int Limite;
int PXi, PYi;
int PXf, PYf;
int AchoAtaque;
int Barra;
int Puntos, MaxPuntos;
int Vida;
int Estado;
int Nivel, MasNivel;
int Reset;
int OpModo;
PShape Logo;
PShape EpicLogo;
StringList Modos;
KetaiSQLite db;
Vibrator Vibrador;     
color ColorBase, ColorNeutro;

// Base de datos
String CREATE_DB_SQL = "CREATE TABLE preferencias ( op TEXT NOT NULL PRIMARY KEY , data FLOAT NOT NULL DEFAULT '0' );";


void setup() {
  //Tamaño de la aplicacion
  size(480, 800);

  //Bariables Globales
  Estado = 0;
  Barra = 30;
  Vida = 100;
  Puntos = 0;
  OpModo = -1;
  Limite = (3*height)/4;
  AchoAtaque = 200;
  Nivel = 0;
  Reset = millis();
  ColorBase = color( 0 );//Negro
  ColorNeutro = color( 255 );//Blanco
  Vibrador = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);

  //Vectores para mostar
  Logo = loadShape("logo.svg");
  EpicLogo = loadShape("EpicLogo.svg");


  //Configuraciones
  textSize(Barra);
  Modos = new StringList();
  Modos.append("ARCADE");
  Modos.append("SOVEVIVE");
  Modos.append("Los Pollos");

  //Base de datos 
  db = new KetaiSQLite( this);
  if ( db.connect() )
  {
    if (!db.tableExists("preferencias")) {
      db.execute(CREATE_DB_SQL);
      if (!db.execute("INSERT into preferencias (`op`,`data`) VALUES ('MaxPuntos', '"+0+"' )")) {
        println("Error en SQLite");
      }
    }
    println("La cantidad de informacion de la db es: "+db.getRecordCount("Preferencias"));

    db.query( "SELECT * FROM preferencias" );

    while ( db.next () )
    {
      if ( db.getString("op").equals("MaxPuntos")) {
        MaxPuntos = db.getInt("data");
      }
      //println( db.getString("op")+ " "+db.getInt("data")+" "+MaxPuntos+" "+db.getRecordCount("Preferencias"));
    }
  }
}

void draw() {
  //println("Maxima Cantidad "+ MaxPuntos);
  switch(Estado)
  {
  case 0:
    //println("Intro");
    Bienbenida();
    break;
  case 1:
    //println("Menu");
    Menu();
    break;
  case 2:
    // println("Jugando Arcade");
    Jugar();
    Reset = millis();
    break;
  case 3:
    // println("Perdiste");
    GameOver();
    break;
  case 4:
    println("Nivel");
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

  if ( Estado == 2) {
    if ( mouseY > Limite) {
      PXi = mouseX;
      PYi = mouseY;
      PXf = PXi;
      PYf = PYi;
    }
  } else if ( Estado == 1) {
    float Pollo = height/8;
    for (int i = 0; i < Modos.size (); i++) {
      if (mouseY > (i+1.5)*Pollo && mouseY < (i+2.5)*Pollo) {
        OpModo = i;
      }
    }
  }
}

void mouseReleased() {
  if ( Estado == 2) {
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
    }
    PXi = 0;
    PYi = 0;
  }
}

void mouseDragged() {
  if ( Estado == 2) {
    if ( (PXi != 0 || PYi != 0)  & mouseY > PYi) {
      PXf = mouseX;
      PYf = mouseY;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Pastalla de Game Over
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void GameOver() {
  if ( Puntos > MaxPuntos) {

    db.execute( "UPDATE Preferencias set data = '"+Puntos+"' where op='MaxPuntos'" );

    db.query( "SELECT * FROM preferencias" );

    while ( db.next () )
    {
      if ( db.getString("op").equals("MaxPuntos")) {
        MaxPuntos = db.getInt("data");
      }
    }
  }

  background(ColorBase);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Perdiste", width/2, height/2);
  text("\""+Puntos+"\"", width/2, height/2 + 2*Barra);
  text("Maximo: "+MaxPuntos, width/2, height/2 + 4*Barra);
  Proyectiles = new ArrayList<Bolla>();
  Malos = new ArrayList<MalaBolla>();
  if ( millis() - Reset > 3000) Estado = 1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Menu de la aplicacion
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void Menu() {
  background(ColorNeutro);
  Opciones();
  if ( OpModo == 0) {
    Estado = 2;
    Empezar();
    Reset =  millis();
    OpModo = -1;
  }
}

void Opciones() {
  pushStyle();
  float Pollo = height/8;

  shapeMode(CENTER);
  shape(EpicLogo, width/2, height/8-height/16, height/4, height/8);


  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(80);

  for (int i = 0; i < Modos.size (); i++) {
    color B = ColorNeutro;
    color T = ColorBase;

    if (mouseY > (i+1.5)*Pollo && mouseY < (i+2.5)*Pollo) {
      B = ColorBase;
      T = ColorNeutro;
    }

    fill(B);
    rect(width/2, (i+2)*Pollo, width - 20, Pollo-20, 20);
    fill(T);
    text(Modos.get(i), width/2, (i+2)*Pollo);
  }
  popStyle();
}

void Empezar() {
  Proyectiles = new ArrayList<Bolla>();
  Malos = new ArrayList<MalaBolla>();
  Vida = 100;
  Puntos = 0;
  Nivel = 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Inicio de la aplicacion
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void Bienbenida() {
  background(ColorBase);
  shapeMode(CENTER);
  shape(Logo, width/2, height/2, width, width);
  if ( millis() - Reset > 3000) {
    Estado = 1;
    Reset =  millis();
  }
}


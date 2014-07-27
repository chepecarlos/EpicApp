// Importando librerias
import ketai.data.*;// Libreria de lite
import android.content.Context;
import android.os.Vibrator;

// Areglos dinamicos 
ArrayList<Bolla> Proyectiles;
ArrayList<MalaBolla> Malos;
ArrayList<Bolla> Poderes;

// Variables Globales
int Limite;
int PXi, PYi;
int PXf, PYf;
PVector Pi, Pf;
int AchoAtaque;
int Barra;
int Puntos, MaxPuntos;
long Rupias, Rupiass;
int Vida;
int Estado;
int Nivel, MasNivel;
int Reset;
int OpModo;
float Tiempo;
PShape Logo;
PShape EpicLogo;
StringList Modos;
KetaiSQLite db;
Vibrator Vibrador;     
color ColorBase, ColorNeutro;

// Base de datos
String SQL_Preferencias = "CREATE TABLE preferencias ( op TEXT NOT NULL PRIMARY KEY , data FLOAT NOT NULL DEFAULT '0' );";
String SQL_Poderes = " CREATE TABLE Poderes ( Poder Text NOT NULL PRIMARY KEY, NivelActual int NOT NULL DEFAULT '0', Descripcion Text, Icono Text);";
String SQL_EstadoPoderes = "CREATE TABLE EstadoPoderes ( Poder Text NOT NULL, Nivel int NOT NULL DEFAULT '1', Costo int NOT NULL, Probabilidad float NOT NULL DEFAULT '0.01');"; 

void setup() {
  //Tamaño de la aplicacion
  size(displayWidth, displayHeight);

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
  Tiempo = millis(); 
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
  Modos.append("Tienda");
  Modos.append("Configurar");

  //Base de datos 
  db = new KetaiSQLite( this);
  if ( db.connect() )
  {
    if (!db.tableExists("preferencias")) {
      db.execute(SQL_Preferencias);
      if (!db.execute("INSERT into preferencias (`op`,`data`) VALUES ('MaxPuntos', '"+0+"' )")) {
        println("Error en SQLite");
      }
      if (!db.execute("INSERT into preferencias (`op`,`data`) VALUES ('Rupias', '"+0+"' )")) {
        println("Error en SQLite");
      }
    }

    if (!db.tableExists("Poderes")) {
      db.execute(SQL_Poderes);
    }

    if (!db.tableExists("EstadoPoderes")) {
      db.execute(SQL_EstadoPoderes);
    }

    println("La cantidad de informacion de la db es: "+db.getRecordCount("Preferencias"));

    db.query( "SELECT * FROM preferencias" );

    while ( db.next () )
    {
      if ( db.getString("op").equals("MaxPuntos")) {
        MaxPuntos = db.getInt("data");
      } else if ( db.getString("op").equals("Rupias")) {
        Rupias = db.getInt("data");
        Rupiass = Rupias;
      }
      //println( db.getString("op")+ " "+db.getInt("data")+" "+MaxPuntos+" "+db.getRecordCount("Preferencias"));
    }
  }
}

void draw() {
  //println("Maxima Cantidad "+ MaxPuntos);
  switch(Estado)
  {
  case 0://Intro del juego
    Bienbenida();
    break;
  case 1://Escoje que hacer
    Menu();
    break;
  case 2:// Ajugar 
    Jugar();
    Reset = millis();
    break;
  case 3:// Perdiste el juego
    GameOver();
    break;
  case 4:
    println("Nivel");
    break;
  case 5://Tienda para compara poderes
    Tienda();
    break;
  case 6: 
    Configurar();
    break;
  default: 
    Estado = 0;
    break;
  }

  // println((millis() - Tiempo ) );
  //  Tiempo = millis();
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
  
  if(Rupias == Rupiass){
    Rupias += Puntos/10;
    db.execute( "UPDATE Preferencias set data = '"+Rupias+"' where op='Rupias'" );

  
  }

  background(ColorBase);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Perdiste", width/2, height/2);
  text("\""+Puntos+"\"", width/2, height/2 + 2*Barra);
  text("Maximo: "+MaxPuntos, width/2, height/2 + 4*Barra);
  text("$" + Rupias,  width/2, height/2 + 6*Barra);
  Proyectiles = new ArrayList<Bolla>();
  Malos = new ArrayList<MalaBolla>();
  if ( millis() - Reset > 3000) {Estado = 1;
   Rupiass = Rupias;
  }
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
  } else if ( OpModo == 3) {
    Estado = 5;
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
  Pi = null;
  Pf = null;
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tienda
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void Tienda() {
  background(ColorNeutro);
  for (int x = 0; x < width; x = x +width/3) {
    for (int y = 0; y < height; y = y + height/3) {
      line(0, y, width, y);
      line(x, 0, x, height);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Configurar
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void Configurar() {
  background(ColorNeutro);
  for (int x = 0; x < width; x = x +width/3) {
    for (int y = 0; y < height; y = y + height/3) {
      line(0, y, width, y);
      line(x, 0, x, height);
    }
  }
}


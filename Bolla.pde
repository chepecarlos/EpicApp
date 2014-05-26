
class Bolla {

  float X, Y;//Posicion
  float Vx, Vy;//Velocidad
  float Vida = 500;//Vida
  float T = 10;//Tamaño
  float Margen = 30;
  float Poder = 100;

  Bolla(float TempX, float TempY, float TempV, float Theta) {
    // println("Creado nodo V:"+ TempV + " Theta:" + Theta);
    X = TempX;
    Y = TempY;
    float V = 10*TempV;
    Vx = V*sin(Theta);
    Vy = V*cos(Theta);
    Poder = (Poder*(-V))/10;
    //println(Poder);
  }

  void Mover() {
    if ( Y < Margen) {
      Vida = 0;
    }
    if ( X < 0 ) {
      Vx = -Vx;
    }
    else if ( X > width) {
      Vx = -Vx;
    }
    Y += Vy;
    X += Vx;
  }

  boolean SigeViva() {
    Vida--;
    if (Vida < 0) {
      return true;
    } 
    else {
      return false;
    }
  }

  void Mostar() {
    fill(0, Vida);
    ellipse(X, Y, T, T);
  }
}


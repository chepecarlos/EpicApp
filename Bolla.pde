class Bolla {

  float X, Y;//Posicion
  float Vx, Vy;//Velocidad
  float Vida = 200;//Vida
  float T = 10;//Tamaño

  Bolla(float TempX, float TempY,  float TempV, float Theta) {
    println("Creado nodo V:"+ TempV + " Theta:" + Theta);
    X = TempX;
    Y = TempY;
    float V = 10*TempV;
    Vx = V*sin(Theta);
    Vy = V*cos(Theta);
  }

  void Mover() {
    if ( Y < 0) {
      Vy = -Vy;
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

  void Mostar() {
    ellipse(X, Y, T, T);
  }
}


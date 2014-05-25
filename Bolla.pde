class Bolla {

  float X, Y;
  float Vx, Vy;
  float Vida = 200;
  float T = 10;

  Bolla(float TempX, float TempY, float TempVx, float TempVy) {
    X = TempX;
    Y = TempY;
    Vx = TempVx;
    Vy = TempVy;
  }

  void Mover() {
    Y += Vy;
    X += Vx;
  }

  void Mostar() {
    ellipse(X, Y, T, T);
  }
}



class MalaBuena extends MalaBolla {

  MalaBuena(float TempX, float TempY, float TempV) {
    super( TempX, TempY, TempV, 0);
    Creditos = 0;
    Salud = 20;
    Golpe = 0;
  }

  MalaBuena(float TempX, float TempY, float TempV, float Theta) {
    super( TempX, TempY, TempV, 0);
    Creditos = 0;
    Salud = 20;
    Golpe = 0;
  }

  MalaBuena(float TempX, float TempY, float TempV, float Theta, float TempT) {
    super( TempX, TempY, TempV, 0, TempT);
    Creditos = 0;
    Salud = 20;
    Golpe = 0;
  }

  void Mostar() {
    super.Mostar();
    Corazon(Posicion.x, Posicion.y, T);
  }
}

void Corazon( float x, float y, float r) {

  y = y - r/4;
  fill(#A42EB4, millis()%255);
  bezier(x, y, x+r/4, y-r/2, 
  x+r/2, y, x, y+(3*r/4));
  bezier(x, y, x-r/4, y-r/2, 
  x-r/2, y, x, y+(3*r/4));
}


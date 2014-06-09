
class MalaBolla extends Bolla {

  int Creditos = 10;
  int Golpe = 10;
  int Vida = 100;

  MalaBolla(float TempX, float TempY, float TempV, float Theta) {
    super(TempX, TempY, TempV, Theta);
    T = 100;
    Margen = -height;
  }

  MalaBolla(float TempX, float TempY, float TempV, float Theta, float TempT) {
    super(TempX, TempY, TempV, Theta);
    T = TempT;
    Margen = -height;
  }

  int Choque(ArrayList<Bolla> Enanos) {

    int j = 0;
    for ( int i = Enanos.size ()-1; i >= 0; i--) {
      Bolla Pollo = Enanos.get(i);
      float Dx = Pollo.X - X;
      float Dy = Pollo.Y - Y;
      float D = sqrt(Dx*Dx + Dy*Dy);
      float miniD = Pollo.T/2 + T/2;
      if ( D < miniD) {
        Vida -=  Pollo.Poder;
        Golpe--;
        j++;
        return i;
      }
    }
    return -1;
  }

  void Mover() {
    super.Mover();
  }

  boolean Ataque() {
    if ( Limite < Y + T/4) {
      return true;
    }
    return false;
  }

  boolean SigeViva() {
    if (Vida < 0) {
      return true;
    } 
    else {
      return false;
    }
  }
}


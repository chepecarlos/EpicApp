
class MalaBolla extends Bolla {

  int Creditos  = 100;
  int Salud = 0;
  int Golpe = 10;
  float Vida = 100;

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

    for ( int i = Enanos.size ()-1; i >= 0; i--) {
      Bolla Pollo = Enanos.get(i);
      PVector D = PVector.sub(Pollo.Posicion, Posicion);
      float miniD = Pollo.T/2 + T/2;
      if ( D.mag() < miniD) {
        Vida -=  Pollo.Poder;
        Golpe--;
        return i;
      }
    }
    return -1;
  }

  void Mover() {
    super.Mover();
  }

  boolean Ataque() {
    if ( Limite < Posicion.y + T/4) {
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
  
  int Poder(){
    return 0;
  }
}



class MalaBomba extends MalaBolla {

  MalaBomba(float TempX, float TempY, float TempV, float Theta) {
    super( TempX, TempY, TempV, Theta);
  }

  MalaBomba(float TempX, float TempY, float TempV, float Theta, float TempT) {
    super( TempX, TempY, TempV, Theta, TempT);
  }

  void Mostar() {
    super.Mostar();
    fill(255, 255, 255);
    ellipse(Posicion.x, Posicion.y, T/2, T/2);
    fill(0, 0, 0);
    ellipse(Posicion.x, Posicion.y, T/4, T/4);
  }

  void Esplota() {
    for ( int i = Malos.size ()-1; i >= 0; i--) {
      MalaBolla MiniMalo = Malos.get(i);
      PVector D = PVector.sub(MiniMalo.Posicion, Posicion);
      if ( D.mag() < T*2) {
        MiniMalo.Vida = 0;
      }
    }
    fill(255, 0, 0);
    ellipse(Posicion.x, Posicion.y, T*2, T*2);
  }
}



class MalaFuego extends MalaBolla {

  MalaFuego(float TempX, float TempY, float TempV, float Theta) {
    super( TempX, TempY, TempV, Theta);
  }

  MalaFuego(float TempX, float TempY, float TempV, float Theta, float TempT) {
    super( TempX, TempY, TempV, Theta, TempT);
  }

  void Mostar() {
    super.Mostar();
    fill(255, 0, 0);
    ellipse(Posicion.x, Posicion.y, T/2, T/2);
  }
  
  int Poder(){
    return 1;
  }
}



class MalaBuena extends MalaBolla {
  
  MalaBuena(float TempX, float TempY, float TempV){
    super( TempX, TempY, TempV, 0);
  }
  
  MalaBuena(float TempX, float TempY, float TempV, float Theta) {
    super( TempX, TempY, TempV, 0);
  }

  MalaBuena(float TempX, float TempY, float TempV, float Theta, float TempT) {
    super( TempX, TempY, TempV, 0, TempT);
  }

  void Mostar() {
    super.Mostar();
    //fill(#A42EB4);
    // ellipse(X, Y, T, T);
    Corazon(X, Y, T);
  }
}

void Corazon( float x, float y, float r) {

  y = y - r/4;
  fill(#A42EB4,millis()%255);
  bezier(x, y, x+r/4, y-r/2, 
  x+r/2, y, x, y+(3*r/4));
  bezier(x, y, x-r/4, y-r/2, 
  x-r/2, y, x, y+(3*r/4));

}


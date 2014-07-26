
class Bolla {

  PVector Posicion, Velocidad;
  float Vida = 500;//Vida
  float T = 10;//Tamaño
  float Margen = 30;
  float Poder = 100;
  color BollaColor = color(0,0,0);

  Bolla(float TempX, float TempY, float TempV, float Theta) {
    // println("Creado nodo V:"+ TempV + " Theta:" + Theta);
    Posicion = new PVector(TempX,TempY);
    Velocidad = new PVector(TempV*sin(Theta),TempV*cos(Theta));
    Poder = (Poder*(-TempV))/10;
    //println(Poder);
  }

  void Mover() {
    if ( Posicion.y < Margen) {
      Vida = 0;
    }
    if ( Posicion.x < 0 || Posicion.x > width) {
      Velocidad.x = - Velocidad.x;
    }
    Posicion.x += Velocidad.x;
    Posicion.y += Velocidad.y;
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
    //pushStyle();

    fill(ColorBase, Vida);
    ellipse(Posicion.x, Posicion.y, T, T);
    
    //popStyle();
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//Funciones con el mouse 
///////////////////////////////////////////////////////////////////////////////////////////////////
void mousePressed() {

  if ( Estado == 2) {
    if ( mouseY > Limite) {
      Pi = new PVector(mouseX, mouseY);
      Pf = new PVector(mouseX, mouseY);
    }
  } else if ( Estado == 1 ) {
    float Pollo = height/8;
    for (int i = 0; i < Modos.size (); i++) {
      if (mouseY > (i+1.5)*Pollo && mouseY < (i+2.5)*Pollo) {
        OpModo = i;
      }
    }
  }
}

void mouseReleased() {
  if ( Estado == 2) {
    if ( Pi != null ) {
      PVector Pt = PVector.sub(Pf, Pi);
      Pt.normalize();
      Proyectiles.add( new Bolla(Pi, Pt) );
      Pi = null;
    }
  }
}

void mouseDragged() {
  if ( Estado == 2) {
    if ( Pi != null && mouseY > Limite) {
      Pf.x = mouseX;
      Pf.y = mouseY;
    }
  }
}


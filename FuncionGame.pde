
////////////////////////////////////////////////////////////////////////////////
// Funciones del juego 
////////////////////////////////////////////////////////////////////////////////

void Jugar() {
  background(ColorNeutro);
  MAtaque();
  ActualizarProyectiles();
  ActualizarMalos();
  Divicion();
  Puntos();
}

void Divicion() {
  pushStyle();
  strokeWeight(4);
  line(0, Limite, width, Limite);
  rectMode(CENTER);
  rect(width/2, Limite, Vida*width/100, Barra/4, 5);
  fill(255);
  ellipse(width/2, Limite, Barra, Barra);
  fill(0);
  textAlign(CENTER, CENTER);
  text(Nivel, width/2, Limite-6);
  popStyle();
}


void Puntos() {
  fill(ColorBase);
  rect(0, 0, width, Barra );
  fill(ColorNeutro);
  textAlign( LEFT);
  text("Puntos "+Puntos+" Max"+MaxPuntos, 0, Barra );
  if (Vida < 1) Estado = 3;
}

void MAtaque() {
  if ( PXi != 0 || PYi != 0) {

    ellipseMode(CENTER);
    noFill();
    arc(PXi, PYi, AchoAtaque, AchoAtaque, 0, PI);
    fill(200);
    line(PXi, PYi, PXf, PYf);
    ellipse(PXi, PYi, 10, 10);
  }
}

void  ActualizarProyectiles() {
  for ( int i = Proyectiles.size ()-1; i >= 0; i--) {
    Bolla MiniProyectil = Proyectiles.get(i);
    MiniProyectil.Mover();
    MiniProyectil.Mostar();
    if (MiniProyectil.SigeViva()) {
      Proyectiles.remove(i);
    }
  }
}

void  ActualizarMalos() {
  for ( int i = Malos.size ()-1; i >= 0; i--) {

    MalaBolla MiniMalo = Malos.get(i);
    MiniMalo.Mover();
    MiniMalo.Mostar();
    IntList Muertos = MiniMalo.Choque(Proyectiles);

    for ( int j = Muertos.size ()-1; j >= 0; j--) {
      Puntos += 10;
      Proyectiles.remove(Muertos.get(j));
    }

    if (MiniMalo.SigeViva()) {
      Vida += MiniMalo.Creditos;
      if ( Vida > 100) Vida = 100;
      Malos.remove(i);
    }

    if ( MiniMalo.Ataque()) {
      Vida -= MiniMalo.Golpe;
      Malos.remove(i);
      Vibrador.vibrate(100);
    }
  }
  if ( Malos.size() < 5*(Puntos/500+1)) {
    Invocar();
  }
}

void Invocar() {
  //print("Invocando");
  for ( int i = 0; i < Nivel*5; i++) {
    Malos.add( new MalaBolla( random(100, width-100), -random(height), random(0.10, 0.20), random(-PI/4, PI/4), random(50, 200)));
  }
}
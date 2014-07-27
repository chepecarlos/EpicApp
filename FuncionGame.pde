
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
  fill(ColorBase);
  line(0, Limite, width, Limite);
  rectMode(CENTER);
  rect(width/2, Limite, Vida*width/100, Barra/4, 5);
  fill(ColorNeutro);
  ellipse(width/2, Limite, Barra, Barra);
  fill(ColorBase);
  textAlign(CENTER, CENTER);
  text(Nivel, width/2, Limite-6);
  popStyle();
}


void Puntos() {
  fill(ColorBase);
  rect(0, 0, width, Barra );
  fill(ColorNeutro);
  textAlign( LEFT);
  text("Puntos "+Puntos+" Max "+MaxPuntos + " $ " + Rupias, 0, Barra );
  if (Vida < 1) Estado = 3;
}

void MAtaque() {
  if ( Pi != null) {
    ellipseMode(CENTER);
    noFill();
    arc(Pi.x, Pi.y, AchoAtaque, AchoAtaque, 0, PI);
    fill(ColorBase);
    line(Pi.x, Pi.y, Pf.x, Pf.y);
    ellipse(Pi.x, Pi.y, 10, 10);
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
    int Muertos = MiniMalo.Choque(Proyectiles);

    if ( Muertos >= 0 ) {
      Proyectiles.remove(Muertos);
      Puntos += 10;
    }

    if (MiniMalo.SigeViva()) {
      Vida += MiniMalo.Creditos;
      if ( Vida > 100) Vida = 100;
      //AnadirPoder(MiniMalo.Poder());
      Malos.remove(i);
    }

    if ( MiniMalo.Ataque()) {
      Vida -= MiniMalo.Golpe;
      Malos.remove(i);
      Vibrador.vibrate(100);
    }
  }
  if ( Malos.size() < 20*(Puntos/500+1)) {
    Invocar();
  }
}

void Invocar() {
  int PEspecial = 10;
  int PNormal = 90; 
  for ( int i = 0; i < Nivel*5; i++) {
    float OP = random(100);
    if ( OP > PEspecial) {
      Malos.add( new MalaBolla( random(100, width-100), -random(height), random(2, 1), random(-PI/4, PI/4), random(50, 200)));
    } else {
      InvocarEspecial(1);
    }
  }
}

void InvocarEspecial(int i) {
  switch(i)
  {
  case 0:
    Malos.add( new MalaBuena(random(100, width-100), -random(height), random(0.10, 0.20), random(-PI/4, PI/4), random(50, 200)));
    break;
  case 1:
    Malos.add( new MalaFuego(random(100, width-100), -random(height), random(0.10, 0.20), random(-PI/4, PI/4), random(50, 200)));
    break;
  }
}

void  AnadirPoder(int P) {
  switch(P) {
  case 1:
    Poderes.add( new BollaRoja());
    break;
  }
}


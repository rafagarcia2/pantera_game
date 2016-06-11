// ETAPA FINAL DO PROJETO

// executa apenas uma vez no início do programa 
PImage img, bg, car, carcrash, wheel, wheelcrash, jump, down;

void setup(){
  size (1280,720);  // tamanho da janela 
  background(#333333); // cor do fundo da janela 
  noFill(); // sem preenchimento 
  stroke(#FFFFFF); // contorno branco
  frameRate(60);
  img = loadImage("imagens/panther.png");
  bg = loadImage("imagens/bg.png");
  car = loadImage("imagens/car.png");
  wheel = loadImage("imagens/wheel.png");
  jump = loadImage("imagens/jump.png");
  down = loadImage("imagens/down.png");
  carcrash = loadImage("imagens/carcrash.png");
  wheelcrash = loadImage("imagens/wheelcrash.png");
}

int start =0;
int dificuldade = 0;
int vel_inicial = 0;
int pular = 0;
int baixar = 0;
int vel_pulo = -8;

//Posicao inicial e tamanho do jogador
int pers_alt = 120;
int pers_lar = 60;
int pers_x = 100-pers_lar/2;
int pers_y = 360-pers_alt/2;


// vidas do Jogador
int vidas = 3;

//Tamanho carro
int car_lar = 200;
int car_alt = 60;

//Tamanho roda
int roda_lar = 50;
int roda_alt = 50;

// Posicao inicial do obstaculo
int numero_Obs = 4;
int[] obs_x = {0,0,0,0,0};
int[] obs_y = {0,0,0,0,0};

// Tipo de obstaculo
int[] tipo_obst = {0,0,0,0,0};

//Tempo do jogo
int tempo = 0;
int pontuacao = 0;
int tempoReal= 0;
//movimentacao
int obs_movimento = 0;
//int pers_movimento = 0;


// executada constantemente 
void draw() {
  if (tempo == 0){
    background(#333333);
    textSize(70);
    textAlign(CENTER, CENTER);
    fill(#ffffff);
    text("Black Panther: The videogame",width/2,120);
    text("Choose Difficulty:",width/2,250);
    textSize(45);
    text("1. Easy",width/2,400);
    text("2. Normal",width/2,450);
    text("3. Hard",width/2,500);
    if (start == 1){
      tempo++;
      for (int i = 0; i < numero_Obs; i++){
        criar_obstaculo(i);
      }
    }
    if (dificuldade == 1){
      vel_inicial = 4;
      
    }
    if (dificuldade == 2){
      vel_inicial = 7;
    }    
    if (dificuldade == 3){
      vel_inicial = 8;
    }
  }
  else if (vidas > 0){
    background(bg);
    desenhar_jogardor(pers_x, pers_y, pers_lar, pers_alt);
    if (pular == 1){
      pers_y += vel_pulo;
      println(pers_y);
      if (pers_y < 50){
        vel_pulo = 10;
      }
      if (pers_y >= 360-pers_alt/2){
        pular = 0;
        vel_pulo = -8;
      }
    }
    desenhar_jogardor(pers_x, pers_y, pers_lar, pers_alt);
    for (int i = 0; i < numero_Obs; i++){
      if (obs_x[i] < -350){ // A partir desse momento o obstaculo comeca a ser desenhado
        criar_obstaculo(i);
        pontuacao++;
      }
      obs_x[i] -= vel_inicial + (tempo/800); //incrementação de dificuldade :)
      
      int a = colisao(obs_x[i], obs_y[i], tipo_obst[i], pers_x, pers_y, pers_lar, pers_alt);
      desenhar_obstaculo(obs_x[i], obs_y[i], tipo_obst[i]);
      //println(obs_x[i], obs_y[i], tipo_obst[i], pers_x, pers_y, pers_lar, pers_alt;
      if (a == 1){ // Se tocou
        if (tipo_obst[i] < 4){
          image(carcrash, obs_x[i], obs_y[i]);
        } else{
          image(wheelcrash, obs_x[i], obs_y[i]);
        }
        criar_obstaculo(i); 
        pers_y = 360-pers_alt/2; // Volta para o meio da tela
        println("Colisão!");
      }
    }
    tempo += 1;
    tempoReal = tempo/60;
    
    fill(#ffffff);
    textSize(20);
    text(("Pontuação: " + pontuacao), 1100, 25);
    text(("Vidas: " + vidas), width/2, 25);
    text(("Tempo: " + tempoReal + "s"), 180, 25);
    start = 0;
    dificuldade = 0;
  }else{
      background(#333333);
      textSize(80);
      textAlign(CENTER, CENTER);
      fill(#ffffff);
      text(("Game Over"), width/2,height/2);
      textSize(33);
      text("For Restart: choose difficulty:",width/2,450);
      text("1. Easy",width/2,525);
      text("2. Normal",width/2,575);
      text("3. Hard",width/2, 625);
      textSize(60);
      text(("Pontuação: " + pontuacao), width/2, 100);
      text(("Tempo: " + tempoReal + "s"), width/2, 150);
      
      if (start == 1){
        restart();
      }
  }
}

void restart(){
  pers_x = 100-pers_lar/2;
  pers_y = 360-pers_alt/2;
  vidas = 3;
  tempo = 1;
  pular = 0;
  baixar = 0;
  pontuacao = 0;
  
  for (int i = 0; i < numero_Obs; i++){
     criar_obstaculo(i);
  }
  if (dificuldade == 1){
    vel_inicial = 4;
  }
  if (dificuldade == 2){
    vel_inicial = 7;
  }    
  if (dificuldade == 3){
    vel_inicial = 10;
  }
}

void desenhar_jogardor(int posicao_x,int posicao_y, int pers_lar, int pers_alt){
  //Funcao destinada a desenhar o personagem
  fill(#FFFFFF);
  stroke(#FFFFFF);
  //rect(posicao_x,posicao_y, largura, altura); // Personagem do Jogo
  if(pular == 1){
    image(jump, posicao_x, posicao_y);}
  
  else{
    if(baixar == 1){image(down, posicao_x, posicao_y);
    }
    else{image(img, posicao_x, posicao_y);
    }
  }
    
    
}

void criar_obstaculo(int i){
  //Funcao destinada a criar a posicao dos obstaculos: 33,33% de carros e 66,67% de rodas. {
   //obs_y[i] = int(random(30, 690));
   int maisdistante = 1280;
   for (int j = 0; j < numero_Obs; j++){
     if (obs_x[j] > maisdistante){
       maisdistante = obs_x[j];
     }
   }
   obs_x[i] = int(random(maisdistante+500,maisdistante+1200));
   println(obs_x[i]);
   tipo_obst[i] = int(random(1, 6));
   if (tipo_obst[i] <= 4){
    obs_y[i] = 400;
  }else{ 
    obs_y[i] = 300;
  }
}

void desenhar_obstaculo(int posicao_x, int posicao_y, int tipo_ostaculo){
  //Funcao destinada a desenhar os obstaculos
  if (tipo_ostaculo <= 4){ 
    //carro(posicao_x - obs_movimento, posicao_y);
    carro(posicao_x, posicao_y);
  }else{ 
    //roda(posicao_x - obs_movimento, posicao_y);
    roda(posicao_x, posicao_y);
  }
}


void carro(int posicao_x, int posicao_y){
  fill(#FF3333);
  stroke(#FF3333);
  //rect(posicao_x + (car_lar/2), posicao_y, car_lar, car_alt);
  image(car, posicao_x, posicao_y);
}

void roda(int posicao_x, int posicao_y){
  fill(#222222);
  stroke(#222222);
  //ellipse(posicao_x + (roda_lar/2), posicao_y, roda_lar, roda_alt);
  image(wheel, posicao_x, posicao_y);
}
int colisao(int obs_x, int obs_y, int obs_tipo, int pers_x, int pers_y, int pers_larg, int pers_alt){
  int obs_larg, obs_alt;  
  if (obs_tipo == 1){
      obs_larg = 0;
      obs_alt = 60;
    }else{
      obs_larg = 0;
      obs_alt = 50;
    }
  
    //if (pers_x < obs_x + obs_larg && pers_x + pers_larg > obs_x &&
    //pers_y < obs_y + obs_alt && pers_y + pers_alt > obs_y){
    if ((((pers_x < obs_x) && (obs_x < pers_larg + pers_x)) || 
    ((obs_x + obs_larg < pers_x + pers_larg) && obs_x + obs_larg > pers_x)) && 
    (((pers_y < obs_y) && (obs_y < pers_alt + pers_y)) ||
    ((obs_y + obs_alt < pers_y + pers_alt) && obs_y + obs_alt > pers_y))){
        // Houve colisão
        vidas -= 1;
        return 1;
    }
    return 0;
}

void keyTyped() {
  // Função destinada a receber os comandos do teclado
  if (int(key) == 49){ // Key 1
     start = 1;
     dificuldade = 1;
     
  }
  if (int(key) == 50){ // Key 2
     start = 1;
     dificuldade = 2;
  }
  if (int(key) == 51){ // Key 3
     start = 1;
     dificuldade = 3;
  }
  if (int(key) == 119){ // Key "w"
     pers_y -= 20;
     pular = 1;
     baixar = 0;
  }
  //if (int(key) == 115){ // Key "s"
  //   pers_y += 20;
     
  //}
  if (pers_y < 0){ // Limitar a teto do jogo
    pers_y = 0;
  }
  if (pers_y > 720-(pers_alt)){ // Limitar a piso do jogo
    pers_y = 720-(pers_alt);
  }
}

//void pular(){
  //while(pers_y >= 340){
  //  pers_y -= 20;
  //}
  //while(pers_y <= 440){
  //  pers_y += 20;
  //}
  //if(tempo
//}


void keyPressed() {
  
 if (int(key) == 115) {
   if (pular != 1){
     pers_y = 400;
     pers_alt = 100;
     pers_lar = 150;
     baixar = 1;
   
   }
 }
}

void keyReleased() {
 if (int(key) == 115) {
   if (pular != 1){
     pers_y = 360-pers_alt/2;
     pers_alt = 120;
     pers_lar = 60;
     baixar = 0;
   }
   
 }
}
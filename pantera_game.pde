// ETAPA 06 DO PROJETO

// executa apenas uma vez no início do programa 
void setup(){
  size (1280,720);  // tamanho da janela 
  background(#333333); // cor do fundo da janela 
  noFill(); // sem preenchimento 
  stroke(#FFFFFF); // contorno branco
}

int start =0;

//Posicao inicial e tamanho do jogador
int pers_alt = 200;
int pers_lar = 75;
int pers_x = 100;
int pers_y = 360;

// vidas do Jogador
int vidas = 3;

//Tamanho carro
int car_lar = 200;
int car_alt = 60;

//Tamanho roda
int roda_lar = 50;
int roda_alt = 50;

// Posicao inicial do obstaculo
int numero_Obs = 5;
int[] obs_x = {0,0,0,0,0};
int[] obs_y = {0,0,0,0,0};

// Tipo de obstaculo
int[] tipo_obst = {0,0,0,0,0};

//Tempo do jogo
int tempo = 0;
int tempo_aleatorio = 0;

//movimentacao
int obs_movimento = 0;
//int pers_movimento = 0;

// executada constantemente 
void draw() {
  if (tempo == 0){
    background(#333333);
    textSize(40);
    textAlign(CENTER, CENTER);
    fill(#ffffff);
    text("Press 'w' or 's' to start",width/2,height/2);
    criar_obstaculo();
    criar_obstaculo();
    if (start == 1){
      tempo++;
    }
  }
  else if (vidas > 0){
    background(#333333);
    desenhar_jogardor(pers_x, pers_y, pers_lar, pers_alt);
    
    if (tempo >= tempo_aleatorio){ // A partir desse momento o obstaculo comeca a ser desenhado
      criar_obstaculo();
      
    }
    for (int i = 0; i < numero_Obs; i++){
      obs_x[i] -= 4 + (tempo/800); //incrementação de dificuldade :)
      
      int a = colisao(obs_x[i], obs_y[i], tipo_obst[i], pers_x, pers_y, pers_lar, pers_alt);
      desenhar_obstaculo(obs_x[i], obs_y[i], tipo_obst[i]);
      //println(obs_x[i], obs_y[i], tipo_obst[i], pers_x, pers_y, pers_lar, pers_alt;
      if (a == 1){ // Se tocou
        obs_x[i] = -100; 
        pers_y = 360; // Volta para o meio da tela
        println("Colição!");
      }
    }
    //obs_movimento+= 4;
    tempo += 1;
  }else{
      background(#333333);
      textSize(40);
      textAlign(CENTER, CENTER);
      fill(#ffffff);
      text("Game Over",width/2,height/2);
      stop();
  }
}

void desenhar_jogardor(int posicao_x,int posicao_y, int largura, int altura){
  //Funcao destinada a desenhar o personagem
  fill(#FFFFFF);
  stroke(#FFFFFF);
  ellipse(posicao_x,posicao_y, largura, altura); // Personagem do Jogo
}

void criar_obstaculo(){
  //Funcao destinada a criar a posicao dos obstaculos: 33,33% de carros e 66,67% de rodas. 
  for (int i = 0; i < numero_Obs; i++){
     obs_y[i] = int(random(30, 690));
     obs_x[i] = int(random(1500,3000));
     tipo_obst[i] = int(random(1, 3));
  }
  tempo_aleatorio = int(random(tempo+900, tempo+1000));
  obs_movimento = 0;
}

void desenhar_obstaculo(int posicao_x, int posicao_y, int tipo_ostaculo){
  //Funcao destinada a desenhar os obstaculos
  if (tipo_ostaculo == 1){ 
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
  ellipse(posicao_x + (car_lar/2), posicao_y, car_lar, car_alt);
}

void roda(int posicao_x, int posicao_y){
  fill(#222222);
  stroke(#222222);
  ellipse(posicao_x + (roda_lar/2), posicao_y, roda_lar, roda_alt);
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
  if (int(key) == 119){ // Key "w"
     pers_y -= 20;
     start = 1;
  }
  if (int(key) == 115){ // Key "s"
     pers_y += 20;
     start = 1;
  }
  if (pers_y < pers_alt/2){ // Limitar a teto do jogo
    pers_y = pers_alt/2;
  }
  if (pers_y > 720-(pers_alt/2)){ // Limitar a piso do jogo
    pers_y = 720-(pers_alt/2);
  }
}

//void keyPressed() {
//  if (int(key) == 115) {
//    pers_y = pers_y + (pers_alt/2);
//    pers_alt = 100;
//    pers_lar = 150;
//    pers_y = pers_y - (pers_alt/2);
    
//  }
//}

//void keyReleased() {
//  if (int(key) == 112) {
//    pers_y = pers_y + (pers_alt/2);
//    pers_alt = 200;
//    pers_lar = 75;
//    pers_y = pers_y - (pers_alt/2);
//  }
//}
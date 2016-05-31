// ETAPA 04 DO PROJETO

// executa apenas uma vez no início do programa 
void setup(){
  size (1280,720);  // tamanho da janela 
  background(#333333); // cor do fundo da janela 
  noFill(); // sem preenchimento 
  stroke(#FFFFFF); // contorno branco
}

//Posicao inicial e tamanho do jogador
int pers_alt = 200;
int pers_lar = 75;
int pers_x = 100;
int pers_y = 360;

//Tamanho carro
int car_lar = 200;
int car_alt = 60;

//Tamanho roda
int roda_lar = 22;
int roda_alt = 22;

// Posicao inicial do obstaculo
 int obs_x = 1280;
 int obs_y = int(random(30, 690));

// Tipo de obstaculo
int tipo_obst = int(random(1, 3));

//Tempo do jogo
int tempo = 0;
int tempo_aleatorio = int(random(500, 750));

//movimentacao
int obs_movimento = 0;
//int pers_movimento = 0;

// executada constantemente 
void draw() {
  background(#333333);  
  desenhar_jogardor(pers_x, pers_y, pers_lar, pers_alt);
  
  if (tempo >= tempo_aleatorio){ // A partir desse momento o obstaculo comeca a ser desenhado
    criar_obstaculo();
  }
  
  desenhar_obstaculo(obs_x, obs_y);
  
  tempo += 1;
  obs_movimento+= 4;
}

void desenhar_jogardor(int posicao_x,int posicao_y, int largura, int altura){
  //Funcao destinada a desenhar o personagem
  ellipse(posicao_x,posicao_y, largura, altura); // Personagem do Jogo
}

void criar_obstaculo(){
  //Funcao destinada a criar a posicao dos obstaculos: 33,33% de carros e 66,67% de rodas. 
  tempo_aleatorio = int(random(tempo+500, tempo+750));
  obs_y = int(random(30, 690));
  tipo_obst = int(random(1, 3));
  obs_movimento = 0;
}

void desenhar_obstaculo(int posicao_x, int posicao_y){
  //Funcao destinada a desenhar os obstaculos
  if (tipo_obst == 1){ 
    carro(posicao_x - obs_movimento, posicao_y);
  }else{ 
    roda(posicao_x - obs_movimento, posicao_y);
  }
}

void carro(int posicao_x, int posicao_y){
  ellipse(posicao_x + (car_lar/2), posicao_y, car_lar, car_alt);
}

void roda(int posicao_x, int posicao_y){
  ellipse(posicao_x + (roda_lar/2), posicao_y, roda_lar, roda_alt);
}

void keyTyped() {
  // Função destinada a receber os comandos do teclado
  if (int(key) == 119){ // Key "w"
     pers_y -= 20;
  }
  if (int(key) == 115){ // Key "s"
     pers_y += 20;
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
//  if (int(key) == 115) {
//    pers_y = pers_y + (pers_alt/2);
//    pers_alt = 200;
//    pers_lar = 75;
//    pers_y = pers_y - (pers_alt/2);
//  }
//}
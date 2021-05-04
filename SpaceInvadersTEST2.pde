Player player;

int Col = 6;
int Row = 3;
boolean hit2 = false;
boolean enemyDead = false;

boolean border = false, timer, tjek;
int oldtime = millis();
Enemy[][] enemy = new Enemy[Col][Row];
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

int enemySize = 20;
float velocity = 1;
int countDeadEnemies;
int enemiesLeft;

String screen = "startScreen";

void setup() {

  size(500, 750);
  background(0);

  player = new Player();

  for (int i=0; i<Col; i++) {
    for (int j=0; j<Row; j++) {
      enemy[i][j] = new Enemy(width/Col*(i)+width/Col/2-enemySize/2, enemySize+ (enemySize+25)*(j));
    }
  }
}


void draw() {

  background(0);

  //-----------CASES-----------------

  switch(screen) {
  case "startScreen": 
    startScreen();

    break;
  case "Game1": 

    timer();
    bullets();
    wallHit();
    hitboxEnemies();
    speedIncrease();
    deadCount();
    playerUpdate();
    gameOver();
    break;

  case "EndScreen":
    endScreen();

    break;
  }
}


//-----FUNKTIONS------------


void startScreen() {

  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("Space", width/2, 65); 
  text("Invaders", width/2, 120);
  int l = 200;
  int b = 100;
  stroke(230);  
  strokeWeight(5);
  fill(255);
  rect(width/2-l/2, height/3-b/2, l, b);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("Start", width/2, height/3+15); 

  boolean hit = dotRect(mouseX, mouseY, 0, width/2-l/2, height/3-b/2, l, b); 

  if (hit) {
    stroke(180);  
    fill(200);
    rect(width/2-l/2, height/3-b/2, l, b);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("Start", width/2, height/3+15);
  }

  strokeWeight(0);
  if (mousePressed) {


    if (hit)
      screen = "Game1";
    mousePressed = false;
  }
}



void endScreen() {

  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("GAME OVER", width/2, 65); 

  int l = 200;
  int b = 100;
  stroke(230);  
  strokeWeight(5);
  fill(255);
  rect(width/2-l/2, height/5-b/2, l, b);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("Main menu", width/2, height/5+15); 

  boolean hit = dotRect(mouseX, mouseY, 0, width/2-l/2, height/5-b/2, l, b); 

  if (hit) {
    stroke(180);  
    fill(200);
    rect(width/2-l/2, height/5-b/2, l, b);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("Main menu", width/2, height/5+15);
  }
  if (mousePressed) {


    if (hit)
      screen = "startScreen";
    mousePressed = false;
  }
}





// Hitbox for dot against rect
boolean dotRect(float dx, float dy, float radius, float rx, float ry, float rw, float rh) {

  // Test variables
  float distX = 0, distY =0;

  // Test for closest edge
  if (dx < rx)          distX = dx - rx;      // left 
  else if (dx > rx+rw) distX = dx - rx+rw;   // right 
  if (dy < ry)          distY = dy - ry;       // top 
  else if (dy > ry+rh) distY = dy -  ry+rh;   // bottom 

  float distance = sqrt( (distX*distX) + (distY*distY) );

  // Collision when radius is bigger than the distance.
  if (distance <= radius) {
    return true;
  }
  return false;
}

void timer() {

  if (timer == false) {

    if (tjek == true) {
      oldtime = millis();
      tjek = false;
    }

    if (millis()-oldtime > 100) {
      timer = !timer;
      tjek = true;
    }
  }
}

void bullets() {

  if (keyPressed && keyCode == UP && timer) {
    bullets.add(new Bullet(player.location.x+10, player.location.y));

    timer = !timer;



    keyPressed = false;
  }

  for (int i = bullets.size()-1; i>=0; i--) {

    Bullet part = bullets.get(i);
    if ( part.location.y < 0) {
      bullets.remove(part);
    }
  }

  for (Bullet part : bullets) {
    part.update();
    part.draw();
  }
}
void wallHit() {

  for (int i=0; i<Col; i++) {
    for (int j=0; j<Row; j++) {
      enemy[i][j].movement();
      enemy[i][j].display();

      if (enemy[i][j].location.x+enemySize > width && enemy[i][j].location.y < height) {
        border = true;
      }

      if (enemy[i][j].location.x < 0&& enemy[i][j].location.y < height) {
        border = true;
      }
    }
  }

  if (border) {

    for (int i=0; i<Col; i++) {
      for (int j=0; j<Row; j++) {

        enemy[i][j].location.y = enemy[i][j].location.y+10;
        enemy[i][j].v = enemy[i][j].v*(-1);
      }
    }
    border = false;
  }
}
void hitboxEnemies() {

  for (int k = bullets.size()-1; k >=0; k--) {
    Bullet part = bullets.get(k);
    for (int i=0; i<Col; i++) {
      for (int j=0; j<Row; j++) {


        boolean hit = dotRect(part.location.x, part.location.y, part.mass/2, enemy[i][j].location.x, enemy[i][j].location.y, enemySize, enemySize);

        if (hit) {

          enemy[i][j] = new Enemy(width/2, height+15);
          hit2 = true;
          countDeadEnemies++;
          enemyDead = true;
        }
      }
    }
    if (hit2) {

      bullets.remove(part);
      hit2 = false;
    }
  }
}
void speedIncrease() {

  if (enemyDead) {
    for (int i=0; i<Col; i++) {
      for (int j=0; j<Row; j++) {
        enemy[i][j].v = enemy[i][j].v*1.1;
      }
    }

    enemyDead = false;
  }
}
void deadCount() {


  println(countDeadEnemies);
  enemiesLeft = Col*Row-countDeadEnemies;

  textSize(25);
  text("Enemies left:" +enemiesLeft, 100, 25);
}


void playerUpdate() {
  player.controls();
  player.display();
}


void gameOver() {

  deadCount();

  if (enemiesLeft == 0) {
    screen = "EndScreen";
  }
}

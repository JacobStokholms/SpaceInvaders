Player player;

int Col = 6;
int Row = 3;
Enemy[][] enemy = new Enemy[Col][Row];

int enemySize = 20;

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



  for (int i=Col-1; i>-1; i--) {
    for (int j=Row-1; j>-1; j--) {
      enemy[i][j].movement();
      enemy[i][j].display();

      if (enemy[i][j].location.x+enemySize > width) {

        for (int k=Col-1; k>-1; k--) {
          for (int l=Row-1; l>-1; l--) {

            enemy[k][l].location.y = enemy[k][l].location.y+10;
            enemy[k][l].v = enemy[k][l].v*(-1);
          }
        }
      }

      if (enemy[i][j].location.x < 0) {

        for (int k=Col-1; k>-1; k--) {
          for (int l=Row-1; l>-1; l--) {

            enemy[k][l].location.y = enemy[k][l].location.y+10;
            enemy[k][l].v = enemy[k][l].v*(-1);
          }
        }
      }
    }
  }



  player.controls();
  player.display();
}

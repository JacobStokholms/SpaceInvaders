class Enemy {

  PVector location, direction;
  int velocity = 1;
  int v = velocity;

  Enemy(int x_, int y_) {
    location = new PVector(x_, y_);
    direction = new PVector();
  }

  void movement() {

    direction = new PVector(v, 0);
    location.add(direction);
/*
    if (location.x > width) {
      location.y = location.y+10;
      v = v*(-1);
    }
    if (location.x < 0) {
      location.y = location.y+10;
      v = v*(-1);
    
  }*/}

  void display() {

    fill(255);
    rect(location.x, location.y, enemySize, enemySize);
  }
}

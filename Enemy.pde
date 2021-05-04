class Enemy {

  PVector location, direction;
  float v = velocity;

  Enemy(int x_, int y_) {
    location = new PVector(x_, y_);
    direction = new PVector();
  }

  void movement() {

    direction = new PVector(v, 0);
    location.add(direction);
  }

  void display() {

    fill(255);
    rect(location.x, location.y, enemySize, enemySize);
  }
}

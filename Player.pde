class Player {
  PVector location, direction;
  int velocity = 5;
  int v = velocity;

  Player() {

    location = new PVector(width/2, height-height/8);
    direction = new PVector(0, 0);
  }


  void controls() {

    if (keyPressed && key == 'a'|| keyPressed && keyCode == LEFT) {

      direction = new PVector(-v, 0);
      location.add(direction);
    }

    if (keyPressed && key == 'd'|| keyPressed && keyCode == RIGHT) {

      direction = new PVector(v, 0);
      location.add(direction);
    }
  }

  void display() {

    fill(255, 0, 0);
    rect(location.x, location.y, 20, 40);
  }
}

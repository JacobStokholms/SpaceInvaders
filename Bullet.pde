class Bullet {
  float x = 0;
  float y = 0;
  float mass = 10;
  
  
  PVector location;
  
  Bullet(float x_, float y_) {
   location = new PVector(x_,y_);
  }

  public void update () {
    location.y = location.y -6;
  }
  void draw() {
    
    fill(255);
    ellipse(location.x, location.y, mass, mass);
  }
}

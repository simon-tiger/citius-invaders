class Spaceship {
  float x, y;
  float w, h;
  float xspeed;
  ArrayList<PVector> bullets;

  Spaceship() {
    bullets = new ArrayList<PVector>();
    
    x = width/2;
    y = height - 60;
    w = 10;
    h = 50;
    
    xspeed = 0;
  }
  
  void draw(boolean update) {
    if (update) {
      this.update();
    }
    
    pushStyle();
    
    fill(200, 200, 255);
    noStroke();
    rect(x, y, w, h);
    
    for (int i = bullets.size() - 1; i >= 0; i--) {
      PVector bullet = bullets.get(i);
      fill(0, 255, 0);
      ellipseMode(CENTER);
      ellipse(bullet.x, bullet.y, w, w);
      if (update) {
        bullet.sub(0, 20);
      }
      
      if (bullet.y < 0) {
        bullets.remove(i);
      }
    }
    
    popStyle();
  }
  
  void update() {
    x += xspeed;
    keepInScreen();
  }
  
  void keepInScreen() {
    x = constrain(x, -w/2, width-w/2);
  }
  
  void emitBullet() {
    bullets.add(new PVector(x + w/2, y + w/2));
  }
  
  void move(float xspeed) {
    this.xspeed = xspeed;
  }
  
}
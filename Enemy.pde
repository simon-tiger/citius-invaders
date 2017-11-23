class Enemy {
  float x, y;
  float r;
  float lowerBound;
  
  float xspeed, yspeed;
  float xprob, yprob;
  
  int col;
  
  DNA dna;
  float fitness;
  
  Enemy(float lowerBound, DNA dna) {
    this.lowerBound = lowerBound;
    this.dna = dna;
    
    r = dna.r;
    
    x = random(r, width-r);
    y = random(r, lowerBound-r);
    
    xspeed = dna.xspeed;
    yspeed = dna.yspeed;
    xprob = dna.xprob;
    yprob = dna.yprob;
    
    col = dna.col;
  }
  
  void draw(boolean update) {
    if (update) {
      this.update();
    }
    
    pushStyle();
    
    fill(col);
    noStroke();
    ellipseMode(RADIUS);
    ellipse(x, y, r, r);
    
    popStyle();
  }
  
  void update() {
    x += xspeed;
    y += yspeed;
    fitness++;
    keepInScreen();
  }
  
  void keepInScreen() {
    if (x >= width - r || x <= r) {
      xspeed = -xspeed;
    } else if (y >= lowerBound - r || y <= r) {
      yspeed = -yspeed;
    } else {
      if (random(1) <= xprob) {
        xspeed = -xspeed;
      } else if (random(1) <= yprob) {
        yspeed = -yspeed;
      }
    }
  }
  
  boolean intersects(PVector bullet, int padding) {
    float d = dist(x, y, bullet.x, bullet.y);
    return d <= r + padding;
  }
  
  boolean intersects(PVector bullet) {
    return intersects(bullet, 0);
  }
  
}
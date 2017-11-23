Spaceship ship;
Population population;

char k;
int kc;
char kPrev;
int kcPrev;

boolean update = true;

void setup() {
  size(960, 540);
  ship = new Spaceship();
  population = new Population();
  population.initialize(6);
}

void draw() {
  background(0);
  stroke(255);
  
  ship.draw(update);
  
  if (population.counter <= 0) {
    update = false;
  }
  population.draw(ship, update);
  
  fill(255);
  textAlign(RIGHT);
  text("Evolution Time in " + population.counter + " frames", width-15, 25);
}

void keyReleased() {
  if (update) {
    if ((k == CODED) && ((kc == LEFT) || (kc == RIGHT))) {
      ship.move(0);
    }
    
    k = kPrev;
    kc = kcPrev;
  }
}

void keyPressed() {
  if (update) {
    kPrev = k;
    kcPrev = kc;
    
    k = key;
    kc = keyCode;
    
    if (key == CODED) {
      if (keyCode == LEFT) {
        ship.move(-4);
      }
      if (keyCode == RIGHT) {
        ship.move(4);
      }
      if (keyCode == UP && population.enemies.size() > 4 && ship.bullets.size() < population.enemies.size()) {
        ship.emitBullet();
      }
    }
    if (key == ' ' && population.enemies.size() > 4 && ship.bullets.size() < population.enemies.size()) {
      ship.emitBullet();
    }
  }
}
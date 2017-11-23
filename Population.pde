class Population {
  ArrayList<Enemy> enemies;
  int size;
  int counter;
  int startTime;
  
  void initialize(int populationSize) {
    enemies = new ArrayList<Enemy>();
    size = populationSize;
    for (int i = 0; i < size; i++) {
      enemies.add(new Enemy(height - 70, new DNA()));
    }
    startTime = 300;
    counter = startTime;
  }
  
  void draw(Spaceship ship, boolean update) {
    line(0, height - 70, width, height - 70);
    
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      enemy.draw(update);
      if (counter <= 0) {
      } else if (enemies.size() <= 4) {
        stroke(0, 0, 255);
        noFill();
        ellipseMode(RADIUS);
        ellipse(enemy.x, enemy.y, enemy.r + 10, enemy.r + 10);
      }
      for (int j = ship.bullets.size() - 1; j >= 0; j--) {
        PVector bullet = ship.bullets.get(j);
        if (enemy.intersects(bullet)) {
          enemies.remove(i);
          ship.bullets.remove(j);
        }
      }
    }
    
    if (update) {
      counter--;
    }
    
    if (counter <= 0) {
      startTime = max(120, startTime - 9);
      generate();
    }
  }
  
  void generate() {
    ArrayList<Enemy> selectedEnemies1 = selection(10);
    ArrayList<Enemy> selectedEnemies2 = (ArrayList)selectedEnemies1.clone();
    while (!selectedEnemies1.isEmpty() || !selectedEnemies2.isEmpty()) {
      int index1 = int(random(selectedEnemies1.size()));
      int index2 = int(random(selectedEnemies2.size()));
      if (index1 == index2) {
        index2 = (index2 + 1) % selectedEnemies2.size();
      }
      Enemy enemy1 = selectedEnemies1.get(index1);
      Enemy enemy2 = selectedEnemies1.get(index2);
      DNA dna1 = enemy1.dna;
      DNA dna2 = enemy2.dna;
      DNA crossedOver = dna1.crossOver(dna2);
      
      int sleepTime = int(300 / map(startTime, 120, 300, 1000, 17));
      if (sleepTime != 0) {
        delay(sleepTime);
      }
      
      pushStyle();
      
      stroke(255, 128, 0);
      line(enemy1.x, enemy1.y, enemy2.x, enemy2.y);
      
      fill(0);
      ellipseMode(RADIUS);
      ellipse(enemy1.x, enemy1.y, enemy1.r + 10, enemy1.r + 10);
      ellipse(enemy2.x, enemy2.y, enemy2.r + 10, enemy2.r + 10);
      
      enemy1.draw(false);
      enemy2.draw(false);
      
      popStyle();
      
      crossedOver = crossedOver.mutation(0.1);
      enemies.add(new Enemy(height - 70, crossedOver));
      selectedEnemies1.remove(index1);
      selectedEnemies2.remove(index2);
    }
  }
  
  ArrayList<Enemy> selection(int k) {
    float sumFitness = 0;
    for (Enemy enemy : enemies) {
      sumFitness += enemy.fitness;
    }
    
    ArrayList<Enemy> selectedEnemies = new ArrayList<Enemy>();
    while (selectedEnemies.size() < k) {
      float randomNum = random(sumFitness);
      for (Enemy enemy : enemies) {
        randomNum -= enemy.fitness;
        if (randomNum < 0) {
          selectedEnemies.add(enemy);
          break;
        }
      }
    }
    
    return selectedEnemies;
  }
}
class DNA {
  float r;
  
  float xspeed, yspeed;
  float xprob, yprob;
  
  int col;
  
  float[] genes;
  float[] min;
  float[] max;
  
  DNA() {
    r = random(10, 70);
    
    xspeed = random(-4, 4);
    yspeed = random(-4, 4);
    
    xprob = random(0.01, 0.07);
    yprob = random(0, 0.07);
    
    col = int(random(5, 255));
    
    genes = new float[]{r, xspeed, yspeed, xprob, yprob, float(col)};
    min = new float[]{10, -4, -4, 0.01, 0, 5};
    max = new float[]{70, 4, 4, 0.07, 0.07, 255};
  }
  
  DNA(float[] genes) {
    r = genes[0];
    
    xspeed = genes[1];
    yspeed = genes[2];
    
    xprob = genes[3];
    yprob = genes[4];
    
    col = int(genes[5]);
    
    this.genes = genes;
    min = new float[]{10, -4, -4, 0.01, 0, 4};
    max = new float[]{70, 4, 4, 0.07, 0.07, 255};
  }
  
  DNA crossOver(DNA otherParent) {
    float[] childGenes = new float[genes.length];
    for (int i = 0; i < childGenes.length; i++) {
      if (random(1) <= 0.5) {
        childGenes[i] = genes[i];        
      } else {
        childGenes[i] = otherParent.genes[i];
      }
    }
    return new DNA(childGenes);
  }
  
  DNA mutation(float mutationRate) {
    float[] newgenes = new float[genes.length];
    for (int i = 0; i < newgenes.length; i++) {
      if (random(1) <= mutationRate) {
        newgenes[i] = constrain(newgenes[i] + random(-1, 1), min[i], max[i]);
      }
    }
    return new DNA(newgenes);
  }
  
}
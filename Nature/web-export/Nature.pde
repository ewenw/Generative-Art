Branch trunk;
void setup() {
  size(800, 600);
  smooth();
  trunk = new Branch(1, 0, 1, 80, -90);
}

void draw(){
  if(keyPressed)
    trunk = new Branch(1, 0, 1, 80, -90);
  background(255);
  trunk.update(width/2, height+100);
  trunk.drawLeaves();
}

int maxLevels = 8;
class Branch {
  int index, level;
  Branch[] children;
  int x, y, endx, endy;
  float angle;
  float strokeW, len, alpha;
  Branch(int level, int index, int nodes, float len, float angle) {
    this.level = level;
    this.index = index;
    this.angle = angle;
    this.len = len;
    strokeW = random(0.7, 1) * pow(200 / level, 0.6); 
    alpha = 255 / pow(level, 0.2); 
    if (level < maxLevels) {
      children = new Branch[nodes];
      for (int i=0; i<nodes; i++) {
        float rand = pow(level, 0.9) * 17;
        if(i==0)
          rand = 3;
        children[i] = new Branch(level + 1, i, nodes + 1, len - random(-2, 8), angle + random(-rand, rand));
      }
    }
  }
  void update(int x, int y){
    this.x = x;
    this.y = y;
    endx = x + (int) (pow(maxLevels - level, 0.2) * len * cos(radians(angle)));
    endy = y + (int) (pow(maxLevels - level, 0.2) * len * sin(radians(angle)));
    if (level < maxLevels) {
      for (Branch child: children){
        child.update(endx, endy);
      }
    }
    if(level > 1)
      drawBranch();
    
  }
  void drawBranch(){
    stroke(130 + level * 4,  80 + level * 4,  18 + level * 4, alpha);
    strokeWeight(strokeW);
    line(x, y, endx, endy);
  }
  void drawLeaves(){
    if (level >= maxLevels - 3){
    noStroke();
    for(int i=0; i<360; i+=120){
      fill(-130 + (trunk.y - y)/4, (trunk.y - y)/3, -130 + (trunk.y - y)/4, 120);
      ellipse(endx + cos(radians(i + angle)) * random(0, 30), endy + sin(radians(i + angle)) * random(0, 30), random(1,11), random(1, 11));
    } 
   }
   if (level < maxLevels) {
      for (Branch child: children){
        child.drawLeaves();
      }
    }
  }
}



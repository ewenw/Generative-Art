Branch trunk;
void setup() {
  size(800, 600);
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
    alpha = 255 ; 
    if (level < maxLevels) {
      children = new Branch[nodes];
      for (int i=0; i<nodes; i++) {
        float rand = pow(level, 0.9) * 17;
        if(i==0)
          rand = 3;
        children[i] = new Branch(level + 1, i, nodes + 1, len - random(-2, 16), angle + random(-rand, rand));
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
    if(level > 1 && level < maxLevels)
      drawBranch();
    
  }
  void drawBranch(){
    stroke(90 + level * 12,  40 + level * 12,  0 + level * 12, alpha);
    strokeWeight(strokeW);
    line(x, y, endx, endy);
  }
  void drawLeaves(){
    if (level >= maxLevels - 3){
    noStroke();
    for(int i=0; i<360; i+=90){
      fill(-130 + (trunk.y - y)/4, (trunk.y - y)/3, -130 + (trunk.y - y)/4, 120);
      float rand = noise(i) * 20;
      ellipse(endx + cos(radians(i + angle)) * random(0, 14), endy + sin(radians(i + angle)) * random(0, 14), rand, rand);
    } 
   }
   if (level < maxLevels) {
      for (Branch child: children){
        child.drawLeaves();
      }
    }
  }
}


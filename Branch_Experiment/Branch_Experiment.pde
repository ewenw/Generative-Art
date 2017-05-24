Branch root;
void setup() {
  size(800, 600);
  smooth();
  root = new Branch(1, 0, 6);
}

void draw(){
  background(255);
  root.update(width/2, height/2);
}

int maxLevels = 8;
class Branch {
  int index, level;
  Branch[] children;
  int x, y, endx, endy;
  float angle;
  float strokeW, rotChange, len, alpha;
  Branch(int level, int index, int nodes) {
    strokeW = 10 / level; 
    alpha = 250 / level; 
    len = 120 / (level+1); 
    angle = random(360); 
    rotChange = random(-4, 4);
    this.level = level;
    this.index = index;
    if (level < maxLevels) {
      children = new Branch[nodes];
      for (int i=0; i<nodes; i++) {
        children[i] = new Branch(level + 1, i, nodes);
      }
    }
  }
  void update(int x, int y){
    this.x = x;
    this.y = y;
    angle += rotChange;
    endx = x + (int) (pow(maxLevels - level, 0.5) * 80 * cos(radians(angle)));
    endy = y + (int) (pow(maxLevels - level, 0.5) * 80 * sin(radians(angle)));
    if (level < maxLevels) {
      for (Branch child: children){
        child.update(endx, endy);
      }
    }
    drawBranch();
  }
  void drawBranch(){
    fill(255);
    stroke(0, alpha/2);
    strokeWeight(strokeW);
    line(x, y, endx, endy);
    //ellipse(endx, endy, len, len);
  }
}


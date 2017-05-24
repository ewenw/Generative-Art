int gridsize = 3;
int gridwidth, gridheight;
Cell[][] cells;
void setup(){
  noStroke();
  size(800, 800);
  gridwidth = width/gridsize;
  gridheight = height/gridsize;
  cells = new Cell[gridwidth][gridheight];
  for(int x = 0; x < gridwidth; x++){
    for(int y = 0; y < gridheight; y++){
      cells[x][y] = new Cell(x, y);
    }
  }
  for(int x = 0; x < gridwidth; x++){
    for(int y = 0; y < gridheight; y++){
      cells[x][y].linkNeighbors();
    }
  }
}

void draw(){
  background(255);
  for(Cell[] cs: cells){
    for(Cell c: cs){
      c.update();
      c.drawCell();
    }
  }
  if(frameCount>30)
    noLoop();
}
class Cell{
  // alive 1, dead 0
  int state = 0, nextstate = 0;
  Cell[] neighbors = new Cell[8];
  int x, y;
  Cell(int x, int y){
     this.x = x;
     this.y = y;
     state = floor(random(2));
  }
  void update(){
    int life = 0;
    for(Cell c: neighbors){
      life += c.state;
    }
    if(state == 1){
      if(life == 3 || life == 4)
        nextstate = 1;
      else
        nextstate = 0;
    }
    if(state == 0){
      if(life == 3)
        nextstate = 1;
      else 
        nextstate = 0;  
    }
  }
  void drawCell(){
    state = nextstate;
    int absx = x * gridsize;
    int absy = y * gridsize;
    if(state == 0)
      fill(255);
    if(state == 1)
      fill(0, 255, 0);
    ellipse(absx, absy, gridsize, gridsize);
  }
  void linkNeighbors(){
    int left = x-1;
    int right = x+1;
    int top = y-1;
    int bottom = y+1;
    if(left < 0)
      left = gridwidth-1;
    if(right > gridwidth-1)
      right = 0;
    if(top < 0)
      top = gridheight-1;
    if(bottom > gridheight-1)
      bottom = 0;
    neighbors[0] = cells[left][top];
    neighbors[1] = cells[x][top];
    neighbors[2] = cells[right][top];
    neighbors[3] = cells[right][y];
    neighbors[4] = cells[right][bottom];
    neighbors[5] = cells[x][bottom];
    neighbors[6] = cells[left][bottom];
    neighbors[7] = cells[left][y]; 
  }
}

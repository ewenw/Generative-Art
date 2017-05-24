PImage logo;

void setup(){
  background(255);
  logo = loadImage("logo.png");
  size(logo.width, logo.height, P3D);
  smooth();
  float ncount = 0.;
  pushMatrix();
  translate(0, 0, -140);
  for(int i=-260; i<width; i+=30){
    strokeWeight(14);
    stroke(255);
    line(i, -500, i+260, height + 500);
  }
  popMatrix();
  strokeWeight(0);
  for(int x=0; x<logo.width-1; x+=10){
    for(int y=0; y<logo.height-1; y+=10){
      ncount+=0.01;
      color c = logo.pixels[x + y * width];
      stroke(c);
      for(int i=0; i< 20; i++){
        pushMatrix();    
        if(c != color(255)){  
          fill(red(c)+random(-4, 4), green(c)+random(-4, 4), blue(c)+random(-4, 4), random(80, 140));
          translate(x + noise(ncount) * 4, y + noise(ncount) * 4, random(-180, -100));       
          float r = random(27,30);
          ellipse(0, 0, r, r);
        }
        popMatrix();
      }
    }
  }
}

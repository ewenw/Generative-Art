void setup(){
  size(800, 800, P3D);
  render();
}
void render(){
  background(0);
  blendMode(ADD);
  fill(255);
  translate(width/2,height/2,-80);
  float[] prev = new float[]{0, 0, 0};  
  colorMode(HSB, 360, 100, 100);  
  for(int i=0; i< 28000; i++){
    strokeWeight(random(1,10));
    color c = color(i % 360, 52, 90);
    stroke(c, 25);
    float[] cur;
    if(i%2 == 0)
      cur = genInnerPoint(80);
    else
      cur = genOuterPoint(5 * pow(i, 2));
    for(int j=0; j<random(2,10); j++){
      pushMatrix();
      rotateY(j);
      line(prev[0], prev[1], prev[2], cur[0], cur[1], cur[2]);
      popMatrix();
    }
    prev = cur;
  }
}
float[] genInnerPoint(int radius){
  return new float[]{random(-radius, radius), random(-radius, radius),
                        random(-radius, radius)};
}
float[] genOuterPoint(float radius){
  float x = random(-1, 1);
  float y = random(-1, 1);
  float z = random(-1, 1);
  float g = pow(x * x + y * y + z * z, 0.5);
  x = radius * x / g;
  y = radius * y / g;
  z = radius * z / g;
  return new float[]{x, y, z};
}
void draw(){
  if(keyPressed)
    render();
}

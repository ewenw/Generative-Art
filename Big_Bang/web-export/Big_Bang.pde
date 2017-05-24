void setup(){
  size(800, 800, P3D);
  background(0);
  blendMode(ADD);
  fill(255);
  translate(width/2,height/2,-80);
  float[] prev = new float[]{0, 0, 0};
  strokeWeight(5);
  colorMode(HSB, 360, 100, 100);  
  for(int i=0; i< 10000; i++){
    color c = color(i % 360, 50, 50);
    stroke(c, 80);
    float[] cur;
    if(i%2 == 0)
      cur = genInnerPoint(50);
    else
      cur = genOuterPoint(i / 30);
    line(prev[0], prev[1], prev[2], cur[0], cur[1], cur[2]);
    prev = cur;
  }
}
float[] genInnerPoint(int radius){
  return new float[]{random(-radius, radius), random(-radius, radius),
                        random(-radius, radius)};
}
float[] genOuterPoint(int radius){
  float x = random(-1, 1);
  float y = random(-1, 1);
  float z = random(-1, 1);
  float g = pow(x * x + y * y + z * z, 0.5);
  x = radius * x / g;
  y = radius * y / g;
  z = radius * z / g;
  return new float[]{x, y, z};
}


void setup() {
  size(800, 600);
  background(0);
  float centerX = 20, centerY = 20;
  float rnoise = 0;
  for (int i=-40; i<width; i+=80) {
    strokeWeight(40);
    stroke(255);
    line(i, 0, i+80, height);
  }
  for (float ang=0; ang<880; ang+=0.1) {
    strokeWeight((ang%255)/8);
    pushMatrix();
    translate(centerX, centerY);
    float rad = radians(ang);
    float radius = noise(rnoise) * 380;
    stroke(ang%250, 250-(ang%255), 250-(ang%255), 10);
    line(radius * cos(rad), radius * sin(rad), radius * cos(PI + rad), radius * sin(PI + rad));
    rnoise+=0.001;
    popMatrix();
    centerX+=random(-0.04, 0.2);
    float dcY = random(-0.08, 0.3);
    if (centerY>height/2)
      dcY = random(-0.2, 0.08);
    centerY+=dcY;
  }
}




SceneManager sm;

void setup() {
  size(800, 800);

  rectMode(CENTER);
  ellipseMode(CENTER);
  textSize(30);

  sm = new SceneManager();
  sm.init();
}

void draw() {
  sm.update();
  sm.draw();
}

void mousePressed() {
  sm.mousePressed();
}

void mouseMoved() {
  sm.mouseMoved();
}
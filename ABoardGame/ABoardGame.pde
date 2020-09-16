

SceneManager sm;

void setup() {
  //fullScreen();
  size(800, 800);

  rectMode(CENTER);
  ellipseMode(CENTER);

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
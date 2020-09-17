public class SceneGameSettings extends Scene {

  private boolean homeButtonHover;

  private boolean darkModeHover, lightModeHover;

  public SceneGameSettings(SceneManager sm) {
    super(sm);

    darkModeHover = false;
    lightModeHover = false;
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
  }

  public void update() {
    // Update
  }

  public void draw() {
    // Draw
    background(backgroundColor());

    textSize(30);
    fill(pionPlayableStrokeColor());
    text("Game Settings", width * 0.5f, height * 0.07f);

    stroke(strokeColor());

    if (darkMode) {
      fill(buttonSelectedColor());
      rect(width * 0.3f, height * 0.305f, width * 0.3f, height * 0.09f);

      if (lightModeHover) {
        fill(buttonHoverColor());
        rect(width * 0.7f, height * 0.305f, width * 0.3f, height * 0.09f);
      }
    } else {
      fill(buttonSelectedColor());
      rect(width * 0.7f, height * 0.305f, width * 0.3f, height * 0.09f);

      if (darkModeHover) {
        fill(buttonHoverColor());
        rect(width * 0.3f, height * 0.305f, width * 0.3f, height * 0.09f);
      }
    }

    if (homeButtonHover) {
      rect(width * 0.15f, height * 0.07f, width * 0.2f, height * 0.06f);
    }

    textSize(15);
    fill(fontColor());
    text("Dark mode", width * 0.3f, height * 0.3f);
    text("Light mode", width * 0.7f, height * 0.3f);
    text("Return to menu", width * 0.15f, height * 0.07f);
  }

  public void mousePressed() {
    if (darkModeHover) {
      darkMode = true;
    } else if (lightModeHover) {
      darkMode = false;
    } else if (homeButtonHover) {
      sm.changeScene(new SceneMainMenu(sm));
    }
  }

  public void mouseMoved() {
    darkModeHover = mouseOnEmp(0.3f, 0.305f, 0.3f, 0.09f);
    lightModeHover = mouseOnEmp(0.7f, 0.305f, 0.5f, 0.09f);
    homeButtonHover = mouseOnEmp(0.15f, 0.07f, 0.2f, 0.06f);
  }
}
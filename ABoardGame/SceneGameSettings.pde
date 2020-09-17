public class SceneGameSettings extends Scene {

  private boolean homeButtonHover;
  private boolean darkModeHover, lightModeHover;
  private boolean player2Hover, aiHover;

  public SceneGameSettings(SceneManager sm) {
    super(sm);

    darkModeHover = false;
    lightModeHover = false;
    player2Hover = false;
    aiHover = false;
    homeButtonHover = false;
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
      rect(width * 0.3f, height * 0.255f, width * 0.25f, height * 0.07f);

      if (lightModeHover) {
        fill(buttonHoverColor());
        rect(width * 0.7f, height * 0.255f, width * 0.25f, height * 0.07f);
      }
    } else {
      fill(buttonSelectedColor());
      rect(width * 0.7f, height * 0.255f, width * 0.25f, height * 0.07f);

      if (darkModeHover) {
        fill(buttonHoverColor());
        rect(width * 0.3f, height * 0.255f, width * 0.25f, height * 0.07f);
      }
    }
    
    if (player2IsAi) {
      fill(buttonSelectedColor());
      rect(width * 0.3f, height * 0.405f, width * 0.25f, height * 0.07f);

      if (player2Hover) {
        fill(buttonHoverColor());
        rect(width * 0.7f, height * 0.405f, width * 0.25f, height * 0.07f);
      }
    } else {
      fill(buttonSelectedColor());
      rect(width * 0.7f, height * 0.405f, width * 0.25f, height * 0.07f);

      if (aiHover) {
        fill(buttonHoverColor());
        rect(width * 0.3f, height * 0.405f, width * 0.25f, height * 0.07f);
      }
    }

    if (homeButtonHover) {
      rect(width * 0.15f, height * 0.07f, width * 0.2f, height * 0.06f);
    }

    textSize(15);
    fill(fontColor());
    text("Dark mode", width * 0.3f, height * 0.25f);
    text("Light mode", width * 0.7f, height * 0.25f);
    text("Ai player 2", width * 0.3f, height * 0.40f);
    text("Human player 2", width * 0.7f, height * 0.40f);
    text("Return to menu", width * 0.15f, height * 0.07f);
  }

  public void mousePressed() {
    if (darkModeHover) {
      darkMode = true;
    } else if (lightModeHover) {
      darkMode = false;
    } else if (homeButtonHover) {
      sm.changeScene(new SceneMainMenu(sm));
    } else if (player2Hover) {
      player2IsAi = false;
    } else if (aiHover) {
      player2IsAi = true;
    }
  }

  public void mouseMoved() {
    darkModeHover = mouseOnEmp(0.3f, 0.255f, 0.3f, 0.07f);
    lightModeHover = mouseOnEmp(0.7f, 0.255f, 0.5f, 0.07f);
    homeButtonHover = mouseOnEmp(0.15f, 0.07f, 0.2f, 0.07f);
    player2Hover = mouseOnEmp(0.7f, 0.405f, 0.3f, 0.07f);
    aiHover = mouseOnEmp(0.3f, 0.405f, 0.5f, 0.07f);
    //homeButtonHover = mouseOnEmp(0.15f, 0.07f, 0.2f, 0.07f);
  }
}
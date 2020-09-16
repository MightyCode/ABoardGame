public class SceneMainMenu extends Scene {
  
  private boolean playButtonHover, settingsButtonHover, quitButtonHover;
  
  public SceneMainMenu(SceneManager sm) {
    super(sm);

    playButtonHover = false;
    settingsButtonHover = false;
    quitButtonHover = false;

    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    textSize(40);
  }

  public void update() {
    // Update 

  }

  public void draw() {
    // Draw
    background(backgroundColor());
    
    fill(pionPlayableStrokeColor());
    text("A Board Game", width * 0.5f, height * 0.12f);
    
    stroke(strokeColor());
    fill(buttonHoverColor());
    
    if (playButtonHover){
      rect(width * 0.5f, height * 0.405f, width * 0.3f, height * 0.09f);
    }
    
    if (settingsButtonHover){
      rect(width * 0.5f, height * 0.655f, width * 0.5f, height * 0.09f);
    }
    
    if (quitButtonHover){
      rect(width * 0.5f, height * 0.905f, width * 0.25f, height * 0.09f);
    }
    
    
    fill(fontColor());
    text("Play", width * 0.5f, height * 0.4f);
    text("Game Settings", width * 0.5f, height * 0.65f);
    text("Quit", width * 0.5f, height * 0.9f);
  }

  public void mousePressed() {
    if (playButtonHover){
      sm.changeScene(new SceneGame(sm));
    } else if (settingsButtonHover){
      //sm.changeScene(new SceneGameSettings(sm));
    } else if (quitButtonHover){
      sm.changeScene(new SceneExit(sm));
    }
  }

  public void mouseMoved() {
    playButtonHover = mouseOnEmp(0.5f, 0.405f, 0.3f, 0.09f);
    settingsButtonHover = mouseOnEmp(0.5f, 0.655f, 0.5f, 0.09f);
    quitButtonHover = mouseOnEmp(0.5f, 0.905f, 0.25f, 0.09f);
  }
}

  
private boolean mouseOnEmp(float posX, float posY, float sizeX, float sizeY){
    return mouseX >= width * posX - width * sizeX / 2
        && mouseX <= width * posX + width * sizeX / 2
        && mouseY >= height * posY - height * sizeY / 2
        && mouseY <= height * posY + height * sizeY / 2;
}
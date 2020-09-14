public class SceneManager {
  Scene currentScene, nextScene = null;


  public SceneManager() {
  }

  public void init() {
    currentScene = new SceneGame(this);
  }

  public void update() {
    if (nextScene != null) {
      currentScene = nextScene;
      nextScene = null;
    }

    currentScene.update();
  }

  public void draw() {
    currentScene.draw();
  }

  public void mousePressed() {
    currentScene.mousePressed();
  }

  public void mouseMoved() {
    currentScene.mouseMoved();
  }

  public void changeScene(Scene nextScene) {
    this.nextScene = nextScene;
  }
}
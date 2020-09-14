public abstract class Scene {
  
  protected SceneManager sceneManager;
  
  public Scene(SceneManager sm){
    sceneManager = sm;
  }
  
  public abstract void update();
  
  public abstract void draw();
  
  public abstract void mousePressed();
  
  public abstract void mouseMoved();
}
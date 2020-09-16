public class SceneGameResult extends Scene {

  private boolean replayButtonHover, homeButtonHover;
  private String textResult;
  private PImage background;

  public SceneGameResult(SceneManager sm, boolean result, boolean ai, PImage lastScreen) {
    super(sm);

    replayButtonHover = false;
    homeButtonHover = false;

    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    textSize(40);

    if (ai) textResult = (result)? "You win against AI": "You loose against AI" ;  
    else    textResult = (result)? "White player win": "Black player win" ;  

    //blur the bakcground
    float v = 1.0 / 30.0;
    float[][] kernel = 
      {{ v, v, v }, 
      { v, v, v }, 
      { v, v, v }};

    background = createImage(lastScreen.width, lastScreen.height, RGB);

    // Loop through every pixel in the image
    for (int y = 1; y < lastScreen.height-1; y++) {   // Skip top and bottom edges
      for (int x = 1; x < lastScreen.width-1; x++) {  // Skip left and right edges
        float sum = 0; // Kernel sum for this pixel
        for (int ky = -1; ky <= 1; ky++) {
          for (int kx = -1; kx <= 1; kx++) {
            // Calculate the adjacent pixel for this kernel point
            int pos = (y + ky) * lastScreen.width + (x + kx);
            // Image is grayscale, red/green/blue are identical
            float val = red(lastScreen.pixels[pos]);
            // Multiply adjacent pixels based on the kernel values
            sum += kernel[ky+1][kx+1] * val;
          }
        }
        // For this pixel in the new image, set the gray value
        // based on the sum from the kernel
        background.pixels[y*lastScreen.width + x] = color(sum);
      }
    }
    // State that there are changes to edgeImg.pixels[]
    background.updatePixels();
  }

  public void update() {
    // Update
  }

  public void draw() {
    // Draw
    image(background, 0, 0);
    
    textSize(40);
    fill(pionPlayableStrokeColor());
    text(textResult, width * 0.5f, height * 0.12f);

    stroke(strokeColor());
    fill(buttonHoverColor());

    if (replayButtonHover) {
      rect(width * 0.5f, height * 0.405f, width * 0.3f, height * 0.09f);
    }

    if (homeButtonHover) {
      rect(width * 0.5f, height * 0.605f, width * 0.5f, height * 0.09f);
    }

    textSize(30);
    fill(fontColor());
    text("Play again", width * 0.5f, height * 0.4f);
    text("Return to the menu", width * 0.5f, height * 0.6f);
  }

  public void mousePressed() {
    if (replayButtonHover) {
      sm.changeScene(new SceneGame(sm));
    } else if (homeButtonHover) {
      sm.changeScene(new SceneMainMenu(sm));
    }
  }

  public void mouseMoved() {
    replayButtonHover = mouseOnEmp(0.5f, 0.405f, 0.3f, 0.09f);
    homeButtonHover = mouseOnEmp(0.5f, 0.605f, 0.5f, 0.09f);
  }
}
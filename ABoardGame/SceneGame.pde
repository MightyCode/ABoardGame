static int MARGIN_X = 100, MARGIN_Y = 100;
static int NUMBER_OF_PIONS = 30;
static int AI_CHOOSE_TIME = 1500; // in millis;
static int PION_SIZE= 40;
static int NO_PION_SIZE = 5; 

public class SceneGame extends Scene {

  ArrayList<Integer>[] board;
  ArrayList<Case> cases;
  ArrayList<Integer> casesPlayable;

  int selectedPion = -1;
  int hoverPion = -1;
  EStates currentPlayer;

  // IA vairable
  boolean player2IsAi = true;
  AI ai = new AI(3, EStates.Black);
  int timeAiChoose;
  Pair<Integer, Integer> aiDecision;

  public SceneGame(SceneManager sm) {
    super(sm);
    
    int floor = 5;
    board = getBoardConfiguration2(floor);
    cases = getCases2(floor);
    assignPions(cases, NUMBER_OF_PIONS);

    currentPlayer = EStates.White;

    if (player2IsAi) ai.InitBoard(board, cases);
  }

  public void update() {
    // Update 
    if (aiTurn()) {
      if (selectedPion == -1 && millis() - timeAiChoose >= AI_CHOOSE_TIME / 2) {
        hoverPion = aiDecision.key;
        selectedPion = aiDecision.key;
        casesPlayable = new ArrayList<Integer>();
        casesPlayable.add(aiDecision.value);
      }
      if (millis() - timeAiChoose >= AI_CHOOSE_TIME) {
        currentPionGoTo(aiDecision.value);
        ai.MakeDecision(aiDecision);
        nextTurn();
      }
    }
  }

  public void draw() {



    // Draw
    background(255);

    fill(0);
    resetStroke();

    // hud
    textAlign(LEFT, CENTER);
    text("Turn" + ((aiTurn())? " (AI)": ""), width * 0.53, height * 0.95);
    if (currentPlayer == EStates.White) fill(255);
    else  fill(0);
    ellipse(width * 0.48, height * 0.95, PION_SIZE, PION_SIZE);

    // lines
    
    for (int i = 0; i < board.length; ++i) {
      for (int j = 0; j < board[i].size() - 1; ++j) {        
        line(cases.get(board[i].get(j)).getX(), 
          cases.get(board[i].get(j)).getY(), 
          cases.get(board[i].get(j + 1)).getX(), 
          cases.get(board[i].get(j + 1)).getY());
      }
    }

    // pions
    for (int i = 0; i < cases.size(); ++i) {
      if (selectedPion == i && isPlayerState(i)) {
        stroke(255, 0, 0);
        strokeWeight(4);
      } else if (hoverPion == i  && isPlayerState(i)) {
        stroke(220, 0, 0);
        strokeWeight(2);
      } else if (selectedPion != -1 && casesPlayable.indexOf(i) != -1) {
        stroke(51, 102, 204);
        strokeWeight(3);
      } else {
        resetStroke();
      }

      switch(cases.get(i).getState()) {
      case White :
        fill(255);
        ellipse(cases.get(i).getX(), cases.get(i).getY(), PION_SIZE, PION_SIZE);
        break;
      case Black :
        fill(0);
        ellipse(cases.get(i).getX(), cases.get(i).getY(), PION_SIZE, PION_SIZE);
        break;
      case Empty :
        fill(255);
        ellipse(cases.get(i).getX(), cases.get(i).getY(), NO_PION_SIZE, NO_PION_SIZE);
        break;
      }
    }
  }

  public void mousePressed() {
    if (aiTurn()) return;

    if (selectedPion != -1) {
      int i = 0;
      while (i < casesPlayable.size()) {
        if (mouseHover(casesPlayable.get(i))) {
          currentPionGoTo(casesPlayable.get(i));
          if (player2IsAi) ai.MakeDecision(new Pair<Integer, Integer>(selectedPion, casesPlayable.get(i)));
          nextTurn();
          return;
        }
        ++i;
      }
    }

    selectedPion = -1;

    if (mouseHover(hoverPion) ) {
      selectPion(hoverPion);
    }
  }

  public void mouseMoved() {
    if (aiTurn()) return;
    hoverPion = -1;
    int i = 0;
    while (i < cases.size() && selectedPion == -1) {

      if (mouseHover(i) && isPlayerState(i)) {
        hoverPion = i;
        break;
      }

      ++i;
    }
  }

  private boolean aiTurn() {
    return player2IsAi && currentPlayer == EStates.Black;
  }

  private boolean isPlayerState(int pionIndex) {
    return cases.get(pionIndex).getState() == currentPlayer;
  }

  void resetStroke() {
    stroke(0);
    strokeWeight(1);
  }

  private boolean mouseHover(int pionIndex) {
    if (pionIndex < 0 || pionIndex >= cases.size()) return false;

    return sqrt(pow(mouseX - cases.get(pionIndex).getX(), 2) + pow(mouseY - cases.get(pionIndex).getY(), 2)) <= PION_SIZE / 2;
  }


  private void selectPion(int pionIndex) {
    selectedPion = pionIndex;
    casesPlayable = casesPlayable(board, cases, selectedPion, currentPlayer);
  }

 private void nextTurn() {
    selectedPion = -1;
    hoverPion = -1;

    if (currentPlayer == EStates.White) {
      currentPlayer = EStates.Black;

      if (player2IsAi) {
        aiDecision = ai.decision();
        timeAiChoose = millis();
      }
    } else {
      currentPlayer =  EStates.White;
    }
  }

  private void currentPionGoTo(int pionTo) {
    cases.get(selectedPion).setState(EStates.Empty);
    cases.get(pionTo).setState(currentPlayer);
  }
}
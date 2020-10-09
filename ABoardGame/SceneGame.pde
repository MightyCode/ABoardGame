static int MARGIN_LEFT = 100, MARGIN_RIGHT = 100, MARGIN_DOWN = 100, MARGIN_UP = 130;
static int POURCENT_PIONS = 60;
static int AI_CHOOSE_TIME = 1500; // in millis;
static int PION_SIZE = 40;
static int NO_PION_SIZE = 5; 

public boolean player2IsAi = true;
EBoards boardConfiguration = EBoards.MoulinModified;

public class SceneGame extends Scene {

  private ArrayList<Integer>[] board;
  private ArrayList<Case> cases;
  private ArrayList<Integer> casesPlayable;

  private int selectedPion = -1;
  private int hoverPion = -1;
  private EStates currentPlayer;

  // IA vairable

  private AI ai = new AI(5, EStates.Black);
  private int timeAiChoose;
  private Pair<Integer, Integer> aiDecision;

  private boolean homeButtonHover;

  private PGraphics renderTarget;

  public SceneGame(SceneManager sm) {
    super(sm);

    homeButtonHover = false;

    int floor = 6;
    
    board = getBoardConfiguration(boardConfiguration, floor);
    cases = getCases(boardConfiguration, floor);
    assignPions(cases, POURCENT_PIONS);

    currentPlayer = EStates.White;

    renderTarget = createGraphics(width, height);

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
    renderTarget.beginDraw();

    drawGame();
    drawHud();

    renderTarget.endDraw();
    image(renderTarget, 0, 0);
  }


  public void drawGame() {
    renderTarget.background(backgroundColor());
    resetStroke();

    // lines

    for (int i = 0; i < board.length; ++i) {
      for (int j = 0; j < board[i].size() - 1; ++j) {        
        renderTarget.line(cases.get(board[i].get(j)).getX(), 
          cases.get(board[i].get(j)).getY(), 
          cases.get(board[i].get(j + 1)).getX(), 
          cases.get(board[i].get(j + 1)).getY());
      }
    }

    // pions
    for (int i = 0; i < cases.size(); ++i) {
      if (selectedPion == i && isPlayerState(i)) {
        renderTarget.stroke(pionSelectedStrokeColor());
        renderTarget.strokeWeight(4);
      } else if (hoverPion == i  && isPlayerState(i)) {
        renderTarget.stroke(pionHoverStrokeColor());
        renderTarget.strokeWeight(2);
      } else if (selectedPion != -1 && casesPlayable.indexOf(i) != -1) {
        renderTarget.stroke(pionPlayableStrokeColor());
        renderTarget.strokeWeight(3);
      } else {
        resetStroke();
      }

      switch(cases.get(i).getState()) {
      case White :
        renderTarget.fill(whitePionColor());
        renderTarget.ellipse(cases.get(i).getX(), cases.get(i).getY(), PION_SIZE, PION_SIZE);
        break;
      case Black :
        renderTarget.fill(blackPionColor());
        renderTarget.ellipse(cases.get(i).getX(), cases.get(i).getY(), PION_SIZE, PION_SIZE);
        break;
      case Empty :
        renderTarget.fill(emptyPionColor());
        renderTarget.ellipse(cases.get(i).getX(), cases.get(i).getY(), NO_PION_SIZE, NO_PION_SIZE);
        break;
      }
    }
  }

  public void drawHud() {
    renderTarget.textAlign(LEFT, CENTER);
    renderTarget.textSize(30);
    renderTarget.fill(fontColor());
    renderTarget.text("Turn" + ((aiTurn())? " (AI)": ""), width * 0.53, height * 0.95);

    if (currentPlayer == EStates.White) renderTarget.fill(whitePionColor());
    else                                renderTarget.fill(blackPionColor());
    renderTarget.ellipse(width * 0.48, height * 0.95, PION_SIZE, PION_SIZE);

    renderTarget.stroke(strokeColor());
    renderTarget.fill(buttonHoverColor());

    if (homeButtonHover) {
      renderTarget.rectMode(CENTER);
      renderTarget.rect(width * 0.15f, height * 0.07f, width * 0.2f, height * 0.06f);
    }

    renderTarget.textSize(15);

    renderTarget.textAlign(CENTER, CENTER);
    renderTarget.fill(fontColor());
    renderTarget.text("Return to menu", width * 0.15f, height * 0.07f);
  }

  public void mousePressed() {
    if (homeButtonHover) {
      sm.changeScene(new SceneMainMenu(sm));
    }

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
    homeButtonHover = mouseOnEmp(0.15f, 0.07f, 0.2f, 0.06f);

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
    renderTarget.stroke(strokeColor());
    renderTarget.strokeWeight(1);
  }

  private boolean mouseHover(int pionIndex) {
    if (pionIndex < 0 || pionIndex >= cases.size()) return false;

    return sqrt(pow(mouseX - cases.get(pionIndex).getX(), 2) + pow(mouseY - cases.get(pionIndex).getY(), 2)) <= PION_SIZE / 2;
  }


  private void selectPion(int pionIndex) {
    selectedPion = pionIndex;
    casesPlayable = casesPlayable(board, cases, selectedPion);
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

    if (!moveAvailable()) {
      renderTarget.beginDraw();
      drawGame();
      renderTarget.endDraw();
      sm.changeScene(new SceneGameResult(sm, currentPlayer == EStates.Black, player2IsAi, renderTarget.get()));
    }
  }

  private void currentPionGoTo(int pionTo) {
    cases.get(selectedPion).setState(EStates.Empty);
    cases.get(pionTo).setState(currentPlayer);
  }

  private boolean moveAvailable() {
    if (cases.size() <= 1) return false;

    ArrayList<Integer> indexCasesOfWhitePlayer = listCasesOf(cases, EStates.White);
    for (int i = 0; i < indexCasesOfWhitePlayer.size(); ++i) {
      if (casesPlayable(board, cases, indexCasesOfWhitePlayer.get(i)).size() > 0) return true;
    }

    return false;
  }
}

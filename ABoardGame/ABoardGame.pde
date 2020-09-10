int[][] board;
ArrayList<Case> cases;
ArrayList<Integer> casesPlayable;

static int MARGIN_X = 150, MARGIN_Y = 150;
static int NUMBER_OF_PIONS = 8;

int selectedPion = -1;
EStates currentPlayer;

void setup() {
  board = getBoardConfiguration1();
  cases = getCases1();
  assignPions(cases, NUMBER_OF_PIONS);

  currentPlayer = EStates.White;

  size(800, 800);

  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {
  background(255);

  fill(0);
  resetStroke();
  // lines
  for (int i = 0; i < board.length; ++i) {
    for (int j = 0; j < board[i].length - 1; ++j) {
      line(cases.get(board[i][j]).getX(), 
        cases.get(board[i][j]).getY(), 
        cases.get(board[i][j + 1]).getX(), 
        cases.get(board[i][j + 1]).getY());
    }
  }

  // pions
  for (int i = 0; i < cases.size(); ++i) {
    if (selectedPion == i) {
      stroke(255, 0, 0);
      strokeWeight(4);
    } else if (selectedPion != -1 && casesPlayable.indexOf(i) != -1) {
      stroke(51, 102, 204);
      strokeWeight(3);
    } else {
      resetStroke();
    }

    switch(cases.get(i).getState()) {
    case White :
      fill(255);
      ellipse(cases.get(i).getX(), cases.get(i).getY(), 50, 50);
      break;
    case Black :
      fill(0);
      ellipse(cases.get(i).getX(), cases.get(i).getY(), 50, 50);
      break;
    case Empty :
      fill(255);
      ellipse(cases.get(i).getX(), cases.get(i).getY(), 5, 5);
      break;
    }
  }
}

void mousePressed() {
  if (selectedPion != -1) {
    int i = 0;
    while(i < casesPlayable.size()){
      if (mouseHover(casesPlayable.get(i))){
        currentPionGoTo(casesPlayable.get(i));
        nextTurn();
        return;
      }
      ++i;
    }
  }

  unselectPion();

  int i = 0;
  while (i < cases.size() && selectedPion == -1) {
    if (cases.get(i).getState() != currentPlayer) {
      ++i;
      continue;
    }

    if (mouseHover(i)) {
      selectPion(i);
      break;
    }

    ++i;
  }
}

void resetStroke() {
  stroke(0);
  strokeWeight(1);
}

boolean mouseHover(int pionIndex) {
  return sqrt(pow(mouseX - cases.get(pionIndex).getX(), 2) + pow(mouseY - cases.get(pionIndex).getY(), 2)) <= 25;
}

void selectPion(int pionIndex) {
  selectedPion = pionIndex;
  casesPlayable = casesPlayable(cases, board, selectedPion, currentPlayer);
}

void unselectPion() {
  selectedPion = -1;
}

void nextTurn() {
  unselectPion();
  if (currentPlayer == EStates.White) currentPlayer =  EStates.Black;
  else currentPlayer =  EStates.White;
}

void currentPionGoTo(int pionTo){
  cases.get(selectedPion).setState(EStates.Empty);
  cases.get(pionTo).setState(currentPlayer);
}
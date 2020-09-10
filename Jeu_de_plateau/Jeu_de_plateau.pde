int[][] board;
ArrayList<Case> cases;

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
  selectedPion = -1;

  int i = 0;
  while (i < cases.size() && selectedPion == -1) {
    if (cases.get(i).getState() != currentPlayer) {
      ++i;
      continue;
    }

    if (sqrt(pow(mouseX - cases.get(i).getX(), 2) + pow(mouseY - cases.get(i).getY(), 2)) <= 25) {
      selectedPion = i;
    }

    ++i;
  }
}

void resetStroke() {
  stroke(0);
  strokeWeight(1);
}
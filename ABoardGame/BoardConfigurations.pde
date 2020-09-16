import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Collectors;

public int sizeX() {
 return width - (MARGIN_RIGHT + MARGIN_LEFT);
}

public int sizeY(){
 return height - (MARGIN_UP + MARGIN_DOWN);
}


public ArrayList<Integer>[] getBoardConfiguration1(int squareSize) {

  ArrayList<Integer>[] board = new ArrayList[squareSize * 2 ];

  for (int i = 0; i < squareSize; ++i) {
    board[i] = new ArrayList();
    board[squareSize + i] = new ArrayList();
    for (int j = 0; j < squareSize; ++j) {
      board[i].add(i * squareSize + j);
      board[squareSize + i].add(i + j * squareSize);
    }
  }

  return board;
}

public ArrayList<Case> getCases1(int squareSize) {
  ArrayList<Case> cases = new ArrayList(squareSize * squareSize);

  int sizeX = sizeX();
  int sizeY = sizeY();

  for (int i = 0; i < squareSize; ++i) {
    for (int j = 0; j < squareSize; ++j) {
      cases.add(
        new Case(MARGIN_RIGHT + (sizeX / (squareSize - 1) * j ), MARGIN_UP + (sizeY / (squareSize - 1) * i))
        );
    }
  }

  return cases;
}

public ArrayList<Integer>[] getBoardConfiguration2(int squareSize) {

  ArrayList<Integer>[] board = new ArrayList[squareSize * 4 + ((squareSize >=2)? 4 : 0)];

  for (int i = 0; i < squareSize; ++i) {
    for (int j = 0; j < 4; ++j) {
      board[i * 4 + j] = new ArrayList();
      for (int x = 0; x < 3; ++x) {
        board[i * 4 + j].add(i * 8 + ((j * 2 + x) - ((j == 3 && x == 2)? (j * 2 + x) : 0)));
      }
    }
  }

  if (squareSize >= 2) {
    for (int j = 0; j < 4; ++j) {
      board[board.length - 4 + j] = new ArrayList();
      for (int floor = 0; floor < squareSize; ++floor) {
        board[board.length - 4 + j].add(1 + 8 * floor + 2 * j);
      }
    }
  }

  return board;
}


public ArrayList<Case> getCases2(int squareSize) {
  ArrayList<Case> cases = new ArrayList(8 * squareSize);


  int sizeX = sizeX();
  int sizeY = sizeY();
  int sq2 = squareSize * 2;

  for (int i = 0; i < squareSize; ++i) {
    cases.add(new Case(MARGIN_RIGHT + (sizeX/sq2 * i), MARGIN_UP + (sizeY/sq2 * i)));
    cases.add(new Case(MARGIN_RIGHT + (sizeX/2), MARGIN_UP + (sizeY/sq2 * i)));
    cases.add(new Case(MARGIN_RIGHT + (sizeX - sizeX/sq2 * i), MARGIN_UP + (sizeY/sq2 * i)));
    cases.add(new Case(MARGIN_RIGHT + (sizeX - sizeX/sq2 * i), MARGIN_UP + (sizeY/2)));
    cases.add(new Case(MARGIN_RIGHT + (sizeX - sizeX/sq2 * i), MARGIN_UP + (sizeY - sizeY/sq2 * i)));
    cases.add(new Case(MARGIN_RIGHT + (sizeX/2), MARGIN_UP + sizeY - sizeY/sq2 * i));
    cases.add(new Case(MARGIN_RIGHT + (sizeX/sq2 * i), MARGIN_UP + sizeY - sizeY/sq2 * i));
    cases.add(new Case(MARGIN_RIGHT + (sizeX/sq2 * i), MARGIN_UP + (sizeY/2)));
  }

  return cases;
}


public void assignPions(ArrayList<Case> cases, int pourcent) {
    final int numberToAttribute = cases.size() * pourcent / 100;
  
  List<Integer> range = new ArrayList(cases.size());
  for (int i= 0; i< cases.size(); i++) {
    range.add(i);
  }

  int attributed = 0;
  int index = 0;

  while (attributed < numberToAttribute) {
    index = (int)random(range.size());

    cases.get(range.get(index)).setState((attributed >= numberToAttribute / 2)? EStates.White : EStates.Black);
    ++attributed;  
    range.remove(index);
  }
}
import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Collectors;

public static int SQUARE_SIZE = 4;

public ArrayList<Integer>[] getBoardConfiguration1() {
  
  ArrayList<Integer>[] board = new ArrayList[SQUARE_SIZE * 2 ];

  for (int i = 0; i < SQUARE_SIZE; ++i) {
    board[i] = new ArrayList();
    board[SQUARE_SIZE + i] = new ArrayList();
    for (int j = 0; j < SQUARE_SIZE; ++j) {
      board[i].add(i * SQUARE_SIZE + j);
      board[SQUARE_SIZE + i].add(i + j * SQUARE_SIZE);
    }
  }

  return board;
}

public ArrayList<Case> getCases1() {
  ArrayList<Case> cases = new ArrayList();

  int sizeX = width - MARGIN_X * 2;
  int sizeY = height - MARGIN_Y * 2;

  for (int i = 0; i < SQUARE_SIZE; ++i) {
    for (int j = 0; j < SQUARE_SIZE; ++j) {
      cases.add(
        new Case(MARGIN_X + (sizeX / (SQUARE_SIZE - 1) * j ), MARGIN_Y + (sizeY / (SQUARE_SIZE - 1) * i))
        );
    }
  }



  return cases;
}

public void assignPions(ArrayList<Case> cases, int numberOfPions) {
  List<Integer> range = new ArrayList(cases.size());
  for (int i= 0; i< cases.size(); i++) {
    range.add(i);
  }

  int attributed = 0;
  int index = 0;

  while (attributed < numberOfPions) {
    index = (int)random(range.size());

    cases.get(range.get(index)).setState((attributed >= numberOfPions / 2)? EStates.White : EStates.Black);
    ++attributed;  
    range.remove(index);
  }
}


public ArrayList<Integer> casesPlayable(ArrayList<Integer>[] board, ArrayList<Case> cases, int selectedCase, EStates currentPlayer) {
  ArrayList<Integer> casesPlayable = new ArrayList();
  int index, indexTemp;

  for (int i = 0; i < board.length; ++i) {
    index = placeOf(board[i], selectedCase);
    if (index == -1) continue;
    indexTemp = index - 1; 

    while (indexTemp >= 0 && cases.get(board[i].get(indexTemp)).getState() == EStates.Empty) {
      --indexTemp;
    }

    if (indexTemp >= 0) {
      if (currentPlayer != cases.get(board[i].get(indexTemp)).getState()) {
        if (casesPlayable.indexOf(board[i].get(indexTemp)) == -1) {
          casesPlayable.add(board[i].get(indexTemp));
        }
      }
    }

    indexTemp = index + 1;
    while (indexTemp < board[i].size() && cases.get(board[i].get(indexTemp)).getState() == EStates.Empty) {
      ++indexTemp;
    }

    if (indexTemp < board[i].size()) {
      if (currentPlayer != cases.get(board[i].get(indexTemp)).getState()) {
        if (casesPlayable.indexOf(board[i].get(indexTemp)) == -1) {
          casesPlayable.add(board[i].get(indexTemp));
        }
      }
    }
  }

  return casesPlayable;
}


public int placeOf(ArrayList<Integer> line, int selectedCase) {

  for (int i = 0; i < line.size(); ++i) {
    if (line.get(i) == selectedCase) {
      return i;
    }
  }

  return -1;
}
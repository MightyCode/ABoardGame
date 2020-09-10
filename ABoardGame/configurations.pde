import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Collectors;

public int[][] getBoardConfiguration1() {
  int[][] board = new int[4 + 4][4];

  for (int i = 0; i < 4; ++i) {
    for (int j = 0; j < 4; ++j) {
      board[i][j] = i * 4 + j;
      board[4 + i][j] = i + j * 4;
    }
  }

  return board;
}

public ArrayList<Case> getCases1() {
  ArrayList<Case> cases = new ArrayList();

  int sizeX = width - MARGIN_X * 2;
  int sizeY = height - MARGIN_Y * 2;

  for (int i = 0; i < 4; ++i) {
    for (int j = 0; j < 4; ++j) {
      cases.add(
        new Case(MARGIN_X + (sizeX / 3 * j ), MARGIN_Y + (sizeY / 3 * i))
        );
    }
  }



  return cases;
}

public void assignPions(ArrayList<Case> cases, int numberOfPions) {
  List<Integer> range = new ArrayList(16);
  for (int i= 0; i<= 15; i++) {
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


public ArrayList<Integer> casesPlayable(ArrayList<Case> cases, int[][] board, int selectedCase, EStates currentPlayer) {
  ArrayList<Integer> casesPlayable = new ArrayList();
  int index, indexTemp;

  for (int i = 0; i < board.length; ++i) {
    index = placeOf(board[i], selectedCase);
    if (index == -1) continue;
    indexTemp = index - 1; 

    while (indexTemp >= 0 && cases.get(board[i][indexTemp]).getState() == EStates.Empty) {
      --indexTemp;
    }

    if (indexTemp >= 0) {
      if (currentPlayer != cases.get(board[i][indexTemp]).getState()) {
        if (casesPlayable.indexOf(board[i][indexTemp]) == -1) {
          casesPlayable.add(board[i][indexTemp]);
        }
      }
    }

    indexTemp = index + 1;
    while (indexTemp < board[i].length && cases.get(board[i][indexTemp]).getState() == EStates.Empty) {
      ++indexTemp;
    }

    if (indexTemp < board[i].length) {
      if (currentPlayer != cases.get(board[i][indexTemp]).getState()) {
        if (casesPlayable.indexOf(board[i][indexTemp]) == -1) {
          casesPlayable.add(board[i][indexTemp]);
        }
      }
    }
  }

  return casesPlayable;
}


public int placeOf(int[] line, int selectedCase) {

  for (int i = 0; i < line.length; ++i) {
    if (line[i] == selectedCase) {
      println(i);
      return i;
    }
  }

  return -1;
}
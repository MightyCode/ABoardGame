public ArrayList<Integer> listCasesOf(ArrayList<Case>cases, EStates player) {
  ArrayList<Integer> toReturn = new ArrayList();
  for (int i = 0; i < cases.size(); ++i) {
    if (cases.get(i).getState() == player) toReturn.add(i);
  }

  return toReturn;
}



public ArrayList<Integer> casesPlayable(ArrayList<Integer>[] board, ArrayList<Case> cases, int selectedCase) {
  EStates currentPlayer = cases.get(selectedCase).getState();
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


public void printBoard(ArrayList<Integer>[] board){
 for (int i = 0; i < board.length; ++i) {
    for (int j = 0; j < board[i].size(); ++j) {
      print(board[i].get(j) + " ");
    }
     println("");
  }
}

public boolean workBoardEquals(ArrayList<Integer>[] board1, ArrayList<Integer>[] board2){
 for (int i = 0; i < board1.length; ++i) {
    for (int j = 0; j < board2[i].size(); ++j) {
      if (board1[i].get(j) != board2[i].get(j)) return false;
    }
  }
  return true;
}

public boolean casesEquals(ArrayList<Case> cases1, ArrayList<Case> cases2){
 for (int i = 0; i < cases1.size(); ++i) {
    if (cases1.get(i).getState() != cases2.get(i).getState()) return false;
  }
  return true;
}


public int CasesHashCode(ArrayList<Case>cases){
    int hashCode = 1;
    for (Case e : cases)
        hashCode = 31*hashCode + (e==null ? 0 : e.hashCode());
    return hashCode; 
}
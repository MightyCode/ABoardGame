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
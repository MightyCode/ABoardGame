
int boardValue(int[][] board, ArrayList<Case> cases, EStates currentPlayer) {
  // disponibilities

  int playerScore = 0, opponentScore = 0;

  playerScore += pow(computeChainScore(board, cases, currentPlayer), /** to see because its help the IA **/ 1);
  print(playerScore + " " + currentPlayer);
  /*opponentScore += computeChainScore(board, cases, (currentPlayer == EStates.White)? EStates.Black : EStates.White);*/

  return playerScore - opponentScore;
}

int computeChainScore(int[][] board, ArrayList<Case> cases, EStates player) {
  int score = 0, temp = 0;

  for (int i = 0; i < board.length; ++i) {
    for (int j = 0; j < board[i].length; ++j) {
      if (cases.get(board[i][j]).getState() == player) {
        ++temp;
        println("hey " + i + " " + j + " " + score);
      } else if (cases.get(board[i][j]).getState() != EStates.Empty) {
        
        score += pow(temp, 2);
        temp = 0;
      }
    }
    score += pow(temp, 2);
    temp = 0;
  }

  return score;
}
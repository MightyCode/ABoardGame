public class AI {
  private ArrayList<Integer>[] workBoard;
  private ArrayList<Case> cases;
  private int floors; // or difficulty of the AI
  private EStates player;

  public AI(int floorPrediction, EStates player) {
    workBoard = null;
    cases = new ArrayList();
    floors = floorPrediction;
    this.player = player;
  }

  public void InitBoard(ArrayList<Integer>[] gameBoard, ArrayList<Case> cases) {
    workBoard = copyArray(gameBoard);
    this.cases = copyCases(cases);
  }

  public void MakeDecision(Pair<Integer, Integer> decision) {
    cases.get(decision.value).setState(cases.get(decision.key).getState());
    cases.get(decision.key).setState(EStates.Empty);
  }

  public void UnMakeDecision(Pair<Integer, Integer> decision) {
    cases.get(decision.key).setState(cases.get(decision.value).getState());
    cases.get(decision.value).setState(opponent(cases.get(decision.value).getState()));
  }

  public Pair<Integer, Integer> decision() {
    Pair<Integer, Integer> best = new Pair(), current = new Pair(0, 0);
    ArrayList<Integer> ourCases, casesPlayable;
    int bestCost = 0, cost;

    ourCases = listCasesOf(cases, player);
    for (int i = 0; i < ourCases.size(); ++i) {
      casesPlayable = casesPlayable(workBoard, cases, ourCases.get(i));
      
      for (int j = 0; j < casesPlayable.size(); ++j) {
        current = new Pair(ourCases.get(i), casesPlayable.get(j));
        MakeDecision(current);
        cost = boardValue(workBoard, cases, player);

        UnMakeDecision(current);
        
        if (best.key == null || cost > bestCost){
          best.key = ourCases.get(i);
          best.value = casesPlayable.get(j);
          bestCost = cost;
        }
      }
    }

    if (best.key == null) return null;
    else return best;
  }

  private int boardValue(ArrayList<Integer>[] board, ArrayList<Case> cases, EStates currentPlayer) {
    // disponibilities

    int playerScore = 0, opponentScore = 0;

    playerScore += pow(computeChainScore(board, cases, currentPlayer), /** to see because its help the IA **/ 1.2);
    opponentScore += computeChainScore(board, cases, (currentPlayer == EStates.White)? EStates.Black : EStates.White);

    return playerScore - opponentScore;
  }

  private int computeChainScore(ArrayList<Integer>[] board, ArrayList<Case> cases, EStates player) {
    int score = 0, temp = 0;

    for (int i = 0; i < board.length; ++i) {
      for (int j = 0; j < board[i].size(); ++j) {
        if (cases.get(board[i].get(j)).getState() == player) {
          ++temp;
        } else if (cases.get(board[i].get(j)).getState() != EStates.Empty) {

          score += pow(temp, 2);
          temp = 0;
        }
      }
      score += pow(temp, 2);
      temp = 0;
    }

    return score;
  }


  private EStates opponent(EStates state) {
    if (state == EStates.White) return EStates.Black;
    else return EStates.White;
  }


  private ArrayList<Integer>[] copyArray(ArrayList<Integer>[] array) {
    ArrayList<Integer>[] newArray = new ArrayList[array.length];

    for (int i = 0; i < newArray.length; ++i) {
      newArray[i] = new ArrayList<Integer>(array[i]);
    }

    return newArray;
  }

  private ArrayList<Case> copyCases(ArrayList<Case> cases) {
    ArrayList<Case> newCases = new ArrayList(cases.size());

    for (int i = 0; i < cases.size(); ++i) {
      newCases.add(cases.get(i).copy());
    }

    return newCases;
  }
}
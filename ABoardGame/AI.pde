public class AI {
  private ArrayList<Integer>[] workBoard;
  private ArrayList<Case> cases;
  private int floors; // or difficulty of the AI
  private EStates player;
  private StateGame state = null;
  private int floorSearched;

  public AI(int floorPrediction, EStates player) {
    workBoard = null;
    cases = new ArrayList();
    floors = floorPrediction;
    floorSearched = 0;
    this.player = player;
  }

  public void InitBoard(ArrayList<Integer>[] gameBoard, ArrayList<Case> cases) {
    workBoard = copyArray(gameBoard);
    this.cases = copyCases(cases);
  }

  public void MakeDecision(Pair<Integer, Integer> decision) {
    privateMakeDecision(decision);
    --floorSearched;
    if (floorSearched <= 0) floorSearched = 0;
  }


  private void privateMakeDecision(Pair<Integer, Integer> decision) {
    cases.get(decision.value).setState(cases.get(decision.key).getState());
    cases.get(decision.key).setState(EStates.Empty);
  }

  private void UnMakeDecision(Pair<Integer, Integer> decision) {
    cases.get(decision.key).setState(cases.get(decision.value).getState());
    cases.get(decision.value).setState(opponent(cases.get(decision.value).getState()));
  }

  public Pair<Integer, Integer> decision() {
    state = null;
    if (state == null) {
      state = new StateGame(player, player, null, null);
    } else {
      
    }
    
    constructStateTree(state, player);
    Pair<Integer, Integer> decision = state.bestDecision();
    //println(decision + " " + state.subStateGame.size());
    return decision;
  }

  public void constructStateTree(StateGame parentNode, EStates currentPlayer) {
    ArrayList<Integer> ourCases, casesPlayable;
    boolean playOnce = false;
    int cost;
    ourCases = listCasesOf(cases, currentPlayer);
    
    for (int i = 0; i < ourCases.size(); ++i) {
      casesPlayable = casesPlayable(workBoard, cases, ourCases.get(i));
      playOnce = playOnce || (casesPlayable.size() > 0);

      for (int j = 0; j < casesPlayable.size(); ++j) {
        Pair<Integer, Integer> current = new Pair(ourCases.get(i), casesPlayable.get(j));
        privateMakeDecision(current);
        ++floorSearched;
        
        if (floorSearched >= floors) {       
          cost = boardValue(workBoard, cases, player);
          StateGame childNode = new StateGame(player, currentPlayer, new BoardCost(cost, currentPlayer, false), current);
          parentNode.addSubStateGame(childNode);
        } else {
                  
          StateGame childNode = new StateGame(player, currentPlayer, null, current);
          parentNode.addSubStateGame(childNode);
          constructStateTree(childNode, opponent(currentPlayer));
        }
        

        UnMakeDecision(current);
        --floorSearched;
      }
    }

    if (!playOnce){
      parentNode.addSubStateGame(new StateGame(player, currentPlayer, new BoardCost(0, currentPlayer, true), null));  
    }
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

public class StateGame {
  private ArrayList<StateGame> subStateGame;
  private EStates playerComputed, playerOfTurn;
  private Pair<Integer, Integer> decisionMade;
  private BoardCost boardCost;

  public StateGame(EStates playerComputed, EStates playerOfTurn, BoardCost cost, Pair<Integer, Integer> decisionMade) {
    subStateGame = new ArrayList();
    this.boardCost = cost;
    this.decisionMade = decisionMade;
    this.playerComputed = playerComputed;
    this.playerOfTurn = playerOfTurn;
  }

  public void addSubStateGame(StateGame stateGame) {
    subStateGame.add(stateGame);
  }

  public Pair<Integer, Integer> bestDecision() {
    if (subStateGame.size() <= 0) {
      return null;
    }

    ArrayList<StateGame> listOfBest = new ArrayList();
    listOfBest.add(subStateGame.get(0));
    int difference;
    BoardCost best = subStateGame.get(0).getBestState(), current;

    for (int i = 1; i < subStateGame.size(); ++i) {
      current = subStateGame.get(i).getBestState();

      difference = best.compare(current, playerComputed);
      if (difference == 0) {
        listOfBest.add(subStateGame.get(i));
      } else if ((playerComputed == playerOfTurn && difference == 1) || (playerComputed != playerOfTurn && difference == -1)) {
        listOfBest.clear();
        listOfBest.add(subStateGame.get(i));
        best = current;
      }
    }
    
    
    StateGame choosen = listOfBest.get((int)random(listOfBest.size()));
    println("Best decision has a cost of " + choosen.boardCost.cost + " and is winner " + choosen.boardCost.endGame + " for " + choosen.boardCost.player);
    return choosen.getDecisionMade();
  }

  public BoardCost getBestState() {
    if (subStateGame.size() <= 0 || boardCost != null) {
      return boardCost;
    } 

    int difference;
    boardCost = subStateGame.get(0).getBestState();
    BoardCost current;

    for (int i = 1; i < subStateGame.size(); ++i) {
      current = subStateGame.get(i).getBestState();
      difference = boardCost.compare(current, playerComputed);

      //println(playerOfTurn + " " + difference + " " + boardCost + " " + current + " " + ((playerComputed == playerOfTurn) ? "max":"min"));
      
      if ((playerComputed == playerOfTurn && difference == -1) 
	      || (playerComputed != playerOfTurn && difference == 1))  boardCost = current;
    }
    //println("return");
    
    return boardCost;
  }


  public BoardCost getBoardCost() {
    return boardCost;
  }

  public Pair<Integer, Integer> getDecisionMade() {
    return decisionMade;
  }
}
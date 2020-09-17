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


    return listOfBest.get((int)random(listOfBest.size())).getDecisionMade();
  }

  public BoardCost getBestState() {
    if (subStateGame.size() <= 0) {
      return boardCost;
    }

    int difference;
    BoardCost best = subStateGame.get(0).getBestState(), current;

    for (int i = 1; i < subStateGame.size(); ++i) {
      current = subStateGame.get(i).getBestState();
      difference = best.compare(current, playerComputed);
       println(playerOfTurn + " " + difference + " " + best + " " + current + " " + ((playerComputed == playerOfTurn) ? "max":"min"));
      if ((playerComputed == playerOfTurn && difference == 1) || (playerComputed != playerOfTurn && difference == -1))  best = current;
    }
    println("return");
    return best;
  }


  public BoardCost getBoardCost() {
    return boardCost;
  }

  public Pair<Integer, Integer> getDecisionMade() {
    return decisionMade;
  }
}
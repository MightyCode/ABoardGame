public class BoardCost {
  private final int cost;
  private final boolean endGame;
  private final EStates player;

  public BoardCost(int cost, EStates player, boolean endGame) {
    this.cost = cost;
    this.endGame = endGame;
    this.player = player;
  }

  public int getCost() {
    return cost;
  }

  public boolean isWinner(EStates player) {
    return this.player == player;
  }
  
  public boolean isEndGame(){
    return endGame; 
  }
  
  public EStates getPlayer(){
   return player; 
  }
  
  public int compare(BoardCost boardCost, EStates truePlayer){
    if (endGame){
      int difference;
        if (isWinner(truePlayer)){
          difference = 1;
          if (isWinner(boardCost.getPlayer())) --difference;
        } else {
          difference = -1;
          if (!isWinner(boardCost.getPlayer())) ++difference;
        }
      return difference;
    }
    
    
    if (cost == boardCost.getCost()) return 0;
    
    if (cost > boardCost.getCost()){
      return 1;
    } else {
      return 0;
    }
  }
  
  @Override
  public String toString(){
    return "boardCost {" + cost + "," + endGame + "," + player + "}";  
  }
}
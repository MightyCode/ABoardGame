public enum EStates {
  White, Black, Empty
}

public class Case {
  private EStates state;
  private int x, y;

  public Case(int x, int y) {
    this.x = x;
    this.y = y;

    state = EStates.Empty;
  }

  public EStates getState() {
    return state;
  }

  public void setState(EStates newState) {
    state = newState;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public Case copy() {
    Case aCase = new Case(x, y);
    aCase.setState(state);
    return aCase;
  }
}
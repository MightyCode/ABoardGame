public boolean darkMode = true;

public color blackPionColor(){
 return (darkMode) ? color(5): color(0);
}

public color whitePionColor(){
 return (darkMode) ? color(240): color(255);
}

public color emptyPionColor(){
 return backgroundColor();
}

public color pionHoverStrokeColor(){
  return (darkMode) ? color(200, 0, 0): color(200, 0, 0);
}

public color pionSelectedStrokeColor(){
  return (darkMode) ? color(220, 0, 0): color(255, 0, 0);
}

public color pionPlayableStrokeColor(){
  return (darkMode) ? color(51, 102, 204): color(53, 112, 230);
}


public color backgroundColor(){
 return (darkMode) ? color(10): color(230);
}

public color strokeColor(){
 return (darkMode) ? color(200): color(0);
}

public color fontColor(){
   return (darkMode) ? color(200): color(0);
}

public color buttonHoverColor(){
  return (darkMode) ? color(80): color(211);
}

public color buttonSelectedColor(){
  return (darkMode) ? color(30): color(240);
}
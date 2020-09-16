public boolean DarkMode = false;

public color blackPionColor(){
 return (DarkMode) ? color(5): color(0);
}

public color whitePionColor(){
 return (DarkMode) ? color(240): color(255);
}

public color emptyPionColor(){
 return backgroundColor();
}

public color pionHoverStrokeColor(){
  return (DarkMode) ? color(200, 0, 0): color(200, 0, 0);
}

public color pionSelectedStrokeColor(){
  return (DarkMode) ? color(220, 0, 0): color(255, 0, 0);
}

public color pionPlayableStrokeColor(){
  return (DarkMode) ? color(51, 102, 204): color(53, 112, 230);
}


public color backgroundColor(){
 return (DarkMode) ? color(10): color(230);
}

public color strokeColor(){
 return (DarkMode) ? color(200): color(0);
}

public color fontColor(){
   return (DarkMode) ? color(200): color(0);
}
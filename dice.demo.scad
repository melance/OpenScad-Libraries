use <dice.scad>

back(15){
  color("red")
  left(30)
  D4(10);

  color("orange")
  D6(10);

  color("yellow")
  right(30)
  D8(10);
}

fwd(15){
  color("green")
  left(30)
  D10(10);

  color("deepskyblue")
  D12(10);

  color("violet")
  right(30)
  D20(10);
}

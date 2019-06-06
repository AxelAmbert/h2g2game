
class player {
  ArrayList<animation> sprite = new ArrayList<animation>();

  boolean[] direction = new boolean[4];
  int last = 0;

  
  player()
  {
    animation up = new animation("Assets/perso/UP_", 9, 80, 90, 90);
    animation left = new animation("Assets/perso/LEFT_", 9, 80, 90, 90);
    animation down = new animation("Assets/perso/DOWN_", 9, 80, 90, 90);
    animation right = new animation("Assets/perso/RIGHT_", 9, 80, 90, 90);
    sprite.add(up);
    sprite.add(left);
    sprite.add(down);
    sprite.add(right);
  }
  
  void drawPlayer(int posX, int posY)
  {
    int i = 0;
    int res = -1;
    
    while (i != 4) {
      if (direction[i]) {
        res = i;
      }
      i++;
    }
    if (res != -1) {
      sprite.get(res).display(posX, posY);
      last = res;
    } else
      sprite.get(last).display(posX, posY);
  }
  
  void playerKeyPressed()
  {
    if (key == CODED) {
      if (keyCode == UP) {
        direction[0] = true;
        sprite.get(0).startAnimation();
      }
      if (keyCode == LEFT) {
        direction[1] = true;
        sprite.get(1).startAnimation();
      }
      if (keyCode == DOWN) {
        direction[2] = true;
        sprite.get(2).startAnimation();
      }
      if (keyCode == RIGHT) {
        direction[3] = true;
        sprite.get(3).startAnimation();
      }
    }
  }
  
  void playerKeyReleased()
  {
    if (key == CODED) {
      if (keyCode == UP) {
        direction[0] = false;
        sprite.get(0).stopAnimation();
      }
      if (keyCode == LEFT) {
        direction[1] = false;
        sprite.get(1).stopAnimation();
      }
      if (keyCode == DOWN) {
        direction[2] = false;
        sprite.get(2).stopAnimation();
      }
      if (keyCode == RIGHT) {
        direction[3] = false;
        sprite.get(3).stopAnimation();
      }
    }
  }
}

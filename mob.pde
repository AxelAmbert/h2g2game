class mob {
  animation wait;
  ArrayList<attack> att = new ArrayList<attack>();
  int x;
  int y;
  int sizeX;
  int sizeY;
  int myArena;
  int lifePoint;
  int damage = -1;
  int damageY = -1;
  int index = 0;
  
  mob(animation anim, int posX, int posY, int _myArena, int _lifePoint)
  {
    myArena = _myArena;
    x = posX;
    y = posY;
    anim.startAnimation();
    sizeX = anim.sizeX;
    sizeY = anim.sizeY;
    wait = anim;
    wait.startAnimation();
    lifePoint = _lifePoint;
  }
  
  void addAttack(attack at)
  {
    att.add(at);
  }
  
  void drawMob(int posX, int posY)
  {
    if (x != -1)
      wait.display(posX + x, posY + y);
    else {
      wait.display(posX, posY);
      fill(color(255, 0, 0));
      rect(posX + sizeX / 2 - lifePoint / 2, posY, lifePoint, 20);
    }
    if (damage != -1)
      drawDamage(damage);
  }
  
  void drawAttack(int posX, int posY)
  {
    att.get(index).drawAtt(600, 200);
    fill(color(255, 0, 0));
    rect(posX + sizeX / 2 - lifePoint / 2, posY, lifePoint, 20);
    if (att.get(index).anim.checkTheEndAnimation()) {
      enemyAttack += 1;
      for (int i = 0; i < friendTeam.size(); i++) {
        
        friendTeam.get(i).lifePoint -= att.get(index).damage;
        if(friendTeam.get(i).lifePoint <= 0)
          friendTeam.remove(i);
      }
    }
  }
  
  boolean checkHitBox(int posX, int posY)
  {
    if (posX + x <= width / 2 && posX + x >= width / 2 - sizeX + 50 && posY + y <= height / 2 && posY + y >= height / 2 - sizeY + 50) {
      return true;
    }
    return false;
  }

  int getArena()
  {
    return myArena;
  }
  
  void drawDamage(int d)
  {
    if (damageY == -1) {
     damageY = 500;
    }
    damage = d;
    damageY -= 1;
    if (damageY == 400) {
      damage = -1;
      damageY = -1;
    }
    fill(color(255, 0, 0, damageY - 350));
    text(d, 200, damageY);
  }
}

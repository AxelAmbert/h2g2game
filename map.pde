
class background {
  
  int speedRight = 0;
  int speedUp = 0;
  int posX;
  int posY;
  boolean t = false;
  
  PImage gameMap;
  ArrayList<mob> mobList = new ArrayList<mob>();
  int nextArena = -1;
  boolean firstIteration = false;


  background()
  {
    
  }
  
  void drawArea()
  {
  }
  
  void keyPressedArea()
  {
  }
  
  void keyReleasedArea()
  {
  }

  void addAMob(mob tmp)
  {
    mobList.add(tmp);
  }
}







class map extends background {
  PImage hit;

  map(String name, int x, int y, int _posX, int _posY)
  {
    posX = _posX;
    posY = _posY;
    gameMap = loadImage(name+ ".png");
    gameMap.resize(x, y);
    hit = loadImage("Assets/map_hitbox.png");
    hit.resize(x, y);
  }

  @Override
  void drawArea()
  {
    color left;
    color up;
    color down;
    color right;
    image(gameMap, posX, posY);

    left = hit.get(posX * -1 + width / 2, posY * -1 + height / 2 + 70);

    up = hit.get(posX * -1 + width / 2 + 40, posY * -1 + height / 2 + 45);
    right = hit.get(posX * -1 + width / 2 + 80, posY * -1 + height / 2 + 70);
    down = hit.get(posX * -1 + width / 2 + 40, posY * -1 + height / 2 + 90);

    if (!t) {
      if ((speedRight > 0 && right != -16777216) || (speedRight < 0 && left != -16777216))
      posX -= speedRight;
      if ((speedUp > 0 && up != -16777216) || (speedUp < 0 && down != -16777216))
        posY += speedUp;
    }
    
    for (int i = 0; i < mobList.size(); i++) {
      mobList.get(i).drawMob(posX, posY);
      if (mobList.get(i).checkHitBox(posX, posY)) {
        if (firstIteration) {
          mobList.remove(i);
          continue;
        }
        nextArena = mobList.get(i).getArena();
        t = true;
      }
    }
    if (t)
      transition += 10;
    if (1800 == transition) {
      t = false;
      areaIndex = nextArena;
      transition = 0;
    }
    firstIteration = false;
    p.drawPlayer(width / 2, height / 2);
    
    
  }

  @Override
  void keyPressedArea()
  {
    
    if (key == CODED) {
      
      if (keyCode == UP) {
        speedUp = SPEED;
      }
      if (keyCode == DOWN) {
        speedUp = -1 * SPEED;
      }
      if (keyCode == LEFT) {
        speedRight = -1 * SPEED;
      }
      if (keyCode == RIGHT) {
        speedRight = SPEED;
      }
    }
  }

  @Override
  void keyReleasedArea()
  {
    if (key == CODED) {
      if (keyCode == DOWN || keyCode == UP) {
        speedUp = 0;
      }
      if (keyCode == LEFT || keyCode == RIGHT) {
        speedRight = 0;
      }
    }
  }
}







class arena extends background {
  // set a 0
  int nbrFriend = 0;
  int selectMob = -1;
  int selectAttack = -1;
  int prevArena;
  
  arena(String name, int x, int y, int _posX, int _posY, int _prevArena)
  {
    posX = _posX;
    posY = _posY;
    gameMap = loadImage(name+ ".png");
    gameMap.resize(x, y);
    prevArena = _prevArena;
  }
  
  
  @Override
  void drawArea()
  {
    image(gameMap, posX, posY);
    
    int tmp = 400;
    for (int i = 0; i < friendTeam.size(); i++) {
      friendTeam.get(i).drawFriend(1000, tmp, this);
      if (nbrFriend == i) {
        friendTeam.get(i).drawBoxAttack();
      }
      tmp += 100;
    }
    
    int y = 200;
    if (enemyAttack == mobList.size()) {
      enemyAttack = -1;
      nbrFriend = 0;
    }
    if (mobList.size() == 0) {
      areaIndex = prevArena;
      area.get(prevArena).firstIteration = true;
    }
    for (int i = 0; i < mobList.size(); i++) {
      if (mobList.get(i).lifePoint <= 0) {
        mobList.remove(i);
        continue;
      }
      if (enemyAttack == i)
        mobList.get(i).drawAttack(100, y);
      else
        mobList.get(i).drawMob(100, y);
      
      if (i == selectMob) {
        fill(200);
        rect(300, y, 50, 50);
      }
      y += 100;
    }
  }
  
  void endOfAttack()
  {
    nbrFriend += 1;
    if (nbrFriend == friendTeam.size()) {
      enemyAttack = 0;
    }
  }
  
  @Override
  void keyPressedArea()
  {
    if (enemyAttack != -1)
      return;
    if (selectMob != -1 && key == CODED) {
      if (keyCode == DOWN) {
        selectMob = (selectMob+1) % mobList.size();
      }
      if (keyCode == UP) {
        selectMob -= 1;
        if (selectMob < 0) {
          selectMob = mobList.size() - 1;
        }
      }
    }
    if (key == ENTER && selectMob != -1) {
      friendTeam.get(nbrFriend).drawAttack(selectAttack, mobList.get(selectMob));
      selectMob = -1;
    }
    if (key == 'a') {
      selectMob = 0;
      selectAttack = 0;
    }
    if (key == 'z' && friendTeam.get(nbrFriend).attackList.size() >= 2) {
      selectMob = 0;
      selectAttack = 1;
    }
  }
}

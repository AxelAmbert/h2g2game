//vitesse
int SPEED = 3;
ArrayList<background> area = new ArrayList<background>();
player p;
int areaIndex = 0;
int transition = 0;
int enemyAttack = -1;

ArrayList<team> friendTeam = new ArrayList<team>();

void setMobMapOne()
{
  area.get(0).addAMob(
    new mob(
      new animation("Assets/enemy/ENEMY_", 16, 200, 250, 90),
      2100, 300, 1, 100)
  );
  area.get(0).addAMob(
    new mob(
      new animation("Assets/enemy/ENEMY_", 16, 200, 250, 90),
      2700, 550, 2, 100)
  );
  area.get(0).addAMob(
    new mob(
      new animation("Assets/enemy/ENEMY_", 16, 200, 250, 90),
      2800, 550, 3, 100)
  );
}

void setup() 
{
  textSize(32);
  p = new player();
  size(1500, 900);

  area.add(new map("Assets/map", 5000, 4900, -1000, -200));
  
  
  area.add(new arena("Assets/battle_background", 1500, 900, 0, 0, 0));
  area.add(new arena("Assets/battle_background", 1500, 900, 0, 0, 0));
  area.add(new arena("Assets/area1", 1500, 900, 0, 0, 0));

  setMobMapOne();

  mob m = new mob(
    new animation("Assets/enemy/ENEMY_", 16, 300, 400, 90),
  -1, 200, 1, 100);
  m.addAttack(
    new attack(
      new animation("Assets/enemyAttack/ENEMY_", 53, 300, 400, 90),
      20
    )
  );
  area.get(2).addAMob(m);

  m = new mob(
    new animation("Assets/enemy/ENEMY_", 16, 300, 400, 90),
  -1, 200, 1, 100);
  m.addAttack(
    new attack(
      new animation("Assets/enemyAttack/ENEMY_", 53, 300, 400, 90),
      20
    )
  );
  area.get(3).addAMob(m);
  
  
  m = new mob(
    new animation("Assets/enemy/ENEMY_", 16, 300, 400, 90),
  -1, 300, 1, 100);
  
  m.addAttack(
    new attack(
        new animation("Assets/enemyAttack/ENEMY_", 53, 300, 400, 90),
        20
    )
  );
  area.get(2).addAMob(m);
  
  m = new mob(
    new animation("Assets/sephiroth_attack1/WAIT_", 4, 300, 200, 90),
  -1, 300, 1, 100);
  
  m.addAttack(
    new attack(
        new animation("Assets/sephiroth_attack1/ATTACK_", 44, 900, 500, 90),
        20
    )
  );
  area.get(1).addAMob(m);
  
  team one = new team(
    new animation("Assets/cloud_wait/WAIT_", 4, 400, 300, 150),
    100
  );

  one.addAttack(
    new attack(
      new animation("Assets/cloud_attack1/ATTACK_", 14, 400, 300, 90),
     20)
  );
  one.addAttack(
    new attack(
      new animation("Assets/cloud_attack2/ATTACK_", 26, 400, 300, 90),
     100)
  );
  
  friendTeam.add(one);

  // la taille de goku             v    v
  team friend = new team(
    new animation("Assets/goku_wait/WAIT_", 4, 300, 320, 150),
    100
  );
  friend.addAttack(
    new attack(
      new animation("Assets/goku_attack/GOKU_ATTACK_", 39, 1000, 320, 100),
      // la puissance attk 
     20)
  );
  friendTeam.add(friend);
}

void draw() 
{
  area.get(areaIndex).drawArea();
  if (transition != 0) {
    fill(0);
    rect(width / 2 - (transition / 2) - 250, height / 2 - (transition / 2), transition + 500, transition);
  }
}

void keyPressed()
{
  area.get(areaIndex).keyPressedArea();
  p.playerKeyPressed();
}

void keyReleased()
{
  area.get(areaIndex).keyReleasedArea();
  p.playerKeyReleased();
}

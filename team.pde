
class team {
  animation anim;
  ArrayList<attack> attackList = new ArrayList<attack>();
  int attack = -1;
  int lifePoint;
  mob mobWhoAttack;
  
  team(animation _anim, int _lifePoint)
  {
    anim = _anim;
    anim.startAnimation();
    lifePoint = _lifePoint;
  }
  
  void drawBoxAttack()
  {
    ArrayList<String> l = new ArrayList<String>();
    l.add("a");
    l.add("z");
    l.add("e");
    l.add("r");
    if (attack != -1)
      return;
    int posX = 100;
    
    for (int i = 0; i < attackList.size(); i++) {
      fill(100);
      // pas un rect mais un image avec l'icon que tu veut
      rect(posX, 750, 100, 100);
      fill(color(0, 0, 0));
      text(l.get(i), posX, 750);
      posX += 150;
    }
  }
  
  void drawFriend(int posX, int posY, arena m)
  {
    if (attack != -1) {
      attackList.get(attack).drawAtt(posX - 600, posY - 100);
      if (attackList.get(attack).anim.checkTheEndAnimation()) {
        mobWhoAttack.lifePoint -= attackList.get(attack).damage;
        mobWhoAttack.drawDamage(attackList.get(attack).damage);
        m.endOfAttack();
        attack = -1;
      }
    } else
      anim.display(posX, posY);
    fill(color(255, 0, 0));
    rect(posX + anim.sizeX / 2 - lifePoint / 2, posY, lifePoint, 20);
  }
  
  void addAttack(attack att)
  {
    attackList.add(att);
  }
  
  void drawAttack(int nb, mob m)
  {
    mobWhoAttack = m;
    attack = nb;
  }
}

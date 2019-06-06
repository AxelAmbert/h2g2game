class attack {

  animation anim;
  int damage;
  
  attack(animation _anim, int _damage)
  {
    anim = _anim;
    _anim.startAnimation();
    damage = _damage;
  }
  
  void drawAtt(int posX, int posY)
  {
    anim.display(posX, posY);
  }
}

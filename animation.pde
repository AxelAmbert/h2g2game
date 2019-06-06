class animation {
  
  int nb;
  int sizeX;
  int sizeY;
  int time;
  int clock;
  int frame;
  PImage[] images;
  int frameR;
  boolean stop = true;

  animation(String name, int _nb, int _sizeX, int _sizeY, int _frameR)
  {
    frameR = _frameR;
    nb = _nb;
    sizeX = _sizeX;
    sizeY = _sizeY;
    time = millis();
    images = new PImage[_nb];
    frame = 1;

    for (int i = 0; i < _nb; i++) {
      String filename = name + nf(i, 3) + ".png";
      images[i] = loadImage(filename);
      images[i].resize(_sizeX, _sizeY);
    }
  }
  
  void display(float xpos, float ypos) {
    clock = millis();
    if (clock - time >= frameR && stop == false) {
      frame = (frame+1) % nb;
      //
      if (frame == 0)
        frame = 1;
      time = millis();
    } else
      frame = (frame) % nb;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
  
  void stopAnimation()
  {
    stop = true;
    frame = 0;
  }
  
  void startAnimation()
  {
    stop = false;
  }

  boolean checkTheEndAnimation()
  {
    if (frame == nb - 1)
      return true;
    return false;
   }
}

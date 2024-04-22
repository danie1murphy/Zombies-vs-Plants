class Plant {

  //variables
  int x;
  int y;
  int w;
  int h;

  int startTime;
  int currentTime;
  int interval;

  boolean shouldRemove;

  int left;
  int right;
  int top;
  int bottom;

  //contructor
  Plant(int pX, int pY, int pW, int pH, int pI) {
    x = pX;
    y = pY;
    w = pW;
    h = pH;
    interval = pI;

    startTime = millis();

    shouldRemove = false;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y+ h/2;
  }

  //function
  void render() {
    noStroke();
    noFill();
    rect(x, y, w, h);
  }
  void shoot() {
    currentTime = millis();
    if (currentTime - startTime > interval) {
      bulletList.add(new Bullet(x, y, 25, 1));
      interval = int(random(3000, 5000));


      // reset the timer
      startTime = millis();
    }
  }
}

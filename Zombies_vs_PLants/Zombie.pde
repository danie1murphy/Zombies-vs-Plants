class Zombie {

  //variables
  int x;
  int y;
  int w;
  int h;

  boolean isMovingLeft;

  int speed;

  int left;
  int right;
  int top;
  int bottom;

  boolean shouldRemove;

  //contructor
  Zombie(int zX, int zY, int zW, int zH, int zS) {
    x = zX;
    y = zY;
    w = zW;
    h = zH;
    speed = zS;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y+ h/2;

    shouldRemove = false;

    isMovingLeft = true;
  }

  //function
  void render() {
    noStroke();
    noFill();
    rect(x, y, w, h);
  }

  void move() {
    if (isMovingLeft == true) {
      x -= speed;

      left = x - w/2;
      right = x + w/2;
      top = y - h/2;
      bottom = y+ h/2;
    }
  }

  void atePlant(Plant aPlant) {
    // if zombie collides w/ plant
    //flag plant to be removed
    if (top <= aPlant.bottom &&
      bottom >= aPlant.top &&
      left <= aPlant.right &&
      right >= aPlant.left) {
      aPlant.shouldRemove = true;
    }
  }
}

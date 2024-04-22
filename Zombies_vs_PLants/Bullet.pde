class Bullet {
  //variables
  int x;
  int y;
  int d;
  int speed;

  boolean shouldRemove;

  int left;
  int right;
  int top;
  int bottom;

  //constructor
  Bullet(int bX, int bY, int bD, int bS) {
    x = bX;
    y = bY;
    d = bD;
    speed = bS;

    shouldRemove = false;

    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y+ d/2;
  }

  void render() {
    circle(x, y, d);
  }

  void move() {
    x += speed;

    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y+ d/2;
  }
  void checkRemove() {
    if (x > 900) {
      shouldRemove = true;
    }
  }
  void shotZombie(Zombie aZombie) {
    // if bullet collides w/ zombie
    //flag zombie to be removed
    if (top <= aZombie.bottom &&
      bottom >= aZombie.top &&
      left <= aZombie.right &&
      right >= aZombie.left) {
      aZombie.shouldRemove = true;
      shouldRemove = true;
    }
  }
  void hitBarrier(Barrier aBarrier) {
    if (top <= aBarrier.bottom &&
      bottom >= aBarrier.top &&
      left <= aBarrier.right &&
      right >= aBarrier.left) {
      shouldRemove = true;
    }
  }
}

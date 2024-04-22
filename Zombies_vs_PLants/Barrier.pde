class Barrier {

  // vars
  int x;
  int y;
  int w;
  int h;
  
  int startTime;
  int currentTime;
  int interval;
  
  int left;
  int right;
  int top;
  int bottom;

  boolean shouldRemove;

  // constructor
  Barrier(int bX, int bY, int bW, int bH) {

    x = bX;
    y = bY;
    w = bW;
    h = bH;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y+ h/2;
    
    startTime = millis();

    shouldRemove = false;
  }

  void render() {
    rectMode(CENTER);
    noStroke();
    fill(#A1AABC);
    rect(x, y, w, h);
  }
  void broken() {
    currentTime = millis();
    if (currentTime - startTime > 10000) {
      shouldRemove = true;


      // reset the timer
      startTime = millis();
    }
  }
}

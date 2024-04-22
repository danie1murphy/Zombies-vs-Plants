class Button {

  // vars
  int x;
  int y;
  int w;
  int h;

  boolean isPressed = false;

  //constructor
  Button(int bX, int bY, int bW, int bH) {

    x = bX;
    y = bY;
    w = bW;
    h = bH;
  }
  void render() {
    rectMode(CENTER);
    noStroke();
    fill(#CE2A2A);
    rect(x, y, w, h);
  }

  boolean isButton(int num, int min, int max) {
    if (num > min && num < max) {
      return true;
    } else {
      return false;
    }
  }
  boolean isInButton(int bUX, int bUY, int bUW, int bUH) {
    int left = bUX - bUW/2;
    int right = bUX + bUW/2;
    int top = bUY - bUH/2;
    int bot = bUY + bUH/2;

    if (isButton(mouseX, left, right) &&
      (isButton(mouseY, top, bot))) {
      return true;
    } else {
      return false;
    }
  }
  void buttonPress() {
    if (isInButton(x, y, w, h)) {
      isPressed = true;
    } else {
      isPressed = false;
    }
  }
}

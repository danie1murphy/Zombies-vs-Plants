
import processing.sound.*;

//declaring my vars
SoundFile ouchSound;
SoundFile theWalkingDeadSound;

ArrayList<Bullet> bulletList;
ArrayList<Zombie> zombieList;
ArrayList<Plant> plantList;
ArrayList<Barrier> barrierList;

PImage[] bulletImgs = new PImage[2];
Animation bulletAnimation;

PImage[] zombieImgs = new PImage[3];
Animation zombieAnimation;

PImage[] plantImgs = new PImage[2];
Animation plantAnimation;

Button b1;
Button b2;
Button b3;

Button b4;
Button b5;
Button b6;
Button b7;
Button b8;
Button b9;
Button b10;
Button b11;
Button b12;

Button b13;

PImage startScreenImg;

PImage backgroundImg;

int money = 0;

int moneyC = #39C46B;

int textC = #CE2A2A;

int state = 0;

void setup() {
  size(1200, 800);
  rectMode(CENTER);

  //initialize my vars

  ouchSound = new SoundFile(this, "ouch.wav");
  theWalkingDeadSound = new SoundFile(this, "theWalkingDead.wav");
  
  startScreenImg = loadImage("startscreen.png");

  backgroundImg = loadImage("background.png");

  zombieList = new ArrayList<Zombie>();
  zombieList.add(new Zombie(width - 75, height/2, 50, 75, 1));
  zombieList.add(new Zombie(width - 75, height/2 - 170, 50, 75, 1));
  zombieList.add(new Zombie(width - 75, height/2 + 170, 50, 75, 1));

  // initialize my array of images
  for (int index = 0; index < zombieImgs.length; index ++) {
    zombieImgs[index] = loadImage("Zombie-" + index + ".png");
  }
  // initialize animation var
  zombieAnimation = new Animation(zombieImgs, 0.015, 1.2);

  plantList = new ArrayList<Plant>();
  plantList.add(new Plant(260, height/2, 50, 50, int(random(1000, 2000))));
  plantList.add(new Plant(260, height/2 - 170, 50, 50, int(random(1000, 2000))));
  plantList.add(new Plant(260, height/2 + 170, 50, 50, int(random(1000, 2000))));

  bulletList = new ArrayList<Bullet>();

  b1 = new Button(width - 75, height/2, 150, 150);
  b2 = new Button(width - 75, height/2 - 170, 150, 150);
  b3 = new Button(width - 75, height/2 + 170, 150, 150);

  b4 = new Button(width - 400, height/2, 70, 150);
  b5 = new Button(width - 400, height/2 - 170, 70, 150);
  b6 = new Button(width - 400, height/2 + 170, 70, 150);
  b7 = new Button(width - 530, height/2, 70, 150);
  b8 = new Button(width - 530, height/2 - 170, 70, 150);
  b9 = new Button(width - 530, height/2 + 170, 70, 150);
  b10 = new Button(width - 675, height/2, 70, 150);
  b11 = new Button(width - 675, height/2 - 170, 70, 150);
  b12 = new Button(width - 675, height/2 + 170, 70, 150);
  
  b13 = new Button(width - 75, height - 75, 150, 150);

  barrierList = new ArrayList<Barrier>();

  // initialize my array of images
  for (int index = 0; index < bulletImgs.length; index ++) {
    bulletImgs[index] = loadImage("Bullet-" + index + ".png");
  }
  // initialize animation var
  bulletAnimation = new Animation(bulletImgs, .008, .25);

  // initialize my array of images
  for (int index = 0; index < plantImgs.length; index ++) {
    plantImgs[index] = loadImage("Plant-" + index + ".png");
  }
  // initialize animation var
  plantAnimation = new Animation(plantImgs, 0.015, 1);
}

void draw() {
  background(42);
  imageMode(CENTER);
  switch(state) {
    //start state
  case 0:
    startScreen();
    break;
  case 1:
    play();
    break;
  case 2:
  }
}

void startScreen() {
  image(startScreenImg, width/2, height/2, width, height);
  if (key == ' ') {
    state = 1;
    money = 1000;
  }
  fill(textC);
  textSize(32);
  textAlign(CENTER);
  text("Press 'Space' to Start", width/2, height/2 - 100);
}

void play() {
  image(backgroundImg, width/2, height/2);

  // play background on loop
  if (theWalkingDeadSound.isPlaying() == false) {
    theWalkingDeadSound.play();
  }

  drawScore(money, width - 150, 70, moneyC);

  money+= 1;

  for (Zombie aZombie : zombieList) {
    aZombie.render();
    aZombie.move();
    zombieAnimation.display(aZombie.x, aZombie.y);
    zombieAnimation.isAnimating = true;
  }

  for (Plant aPlant : plantList) {
    aPlant.render();
    aPlant.shoot();
    plantAnimation.display(aPlant.x, aPlant.y);
    plantAnimation.isAnimating = true;
  }

  for (Bullet aBullet : bulletList) {
    aBullet.render();
    aBullet.move();
    aBullet.checkRemove();
    bulletAnimation.display(aBullet.x, aBullet.y);
    bulletAnimation.isAnimating = true;
  }
  for (Barrier aBarrier : barrierList) {
    aBarrier.render();
    aBarrier.broken();
  }

  // for loop to remove used bullets
  for (int i = bulletList.size() - 1; i >= 0; i--) {
    Bullet aBullet = bulletList.get(i);
    if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
    }

    for (Zombie aZombie : zombieList) {
      aBullet.shotZombie(aZombie);
      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    for (Barrier aBarrier : barrierList) {
      aBullet.hitBarrier(aBarrier);
      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }
  }

  // for loop to remove dead Zombies
  for (int i = zombieList.size() - 1; i >= 0; i--) {
    Zombie aZombie = zombieList.get(i);


    if (aZombie.shouldRemove == true) {
      zombieList.remove(aZombie);
      ouchSound.play();
    }
  }
  for (int i = plantList.size() - 1; i >= 0; i--) {
    Plant aPlant = plantList.get(i);


    if (aPlant.shouldRemove == true) {
      plantList.remove(aPlant);
      ouchSound.play();
    }
  }

  for (int i = plantList.size() - 1; i >= 0; i--) {
    Plant aPlant = plantList.get(i);

    for (Zombie aZombie : zombieList) {
      aZombie.atePlant(aPlant);
    }
  }
  for (int i = barrierList.size() - 1; i >= 0; i--) {
    Barrier aBarrier = barrierList.get(i);


    if (aBarrier.shouldRemove == true) {
      barrierList.remove(aBarrier);
    }
  }
  reset();
}

void reset() {
  if(key == 'r') {
    state = 0;
  }
}

void drawScore(int score, int x, int y, color c) {
  textSize(64);
  fill(c);
  textAlign(CENTER, CENTER);
  text("¶ " + score, x, y);
}

void mouseReleased() {
  b1.buttonPress();
  if (b1.isPressed == true && money >= 200) {
    zombieList.add(new Zombie(width - 75, height/2, 50, 75, 1));
    money -= 200;
  }
  b2.buttonPress();
  if (b2.isPressed == true && money >= 200) {
    zombieList.add(new Zombie(width - 75, height/2 - 170, 50, 75, 1));
    money -= 200;
  }
  b3.buttonPress();
  if (b3.isPressed == true && money >= 200) {
    zombieList.add(new Zombie(width - 75, height/2 + 170, 50, 75, 1));
    money -= 200;
  }



  b4.buttonPress();
  if (b4.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b4.x, b4.y + 20, 50, 50));
    money -= 50;
  }
  b5.buttonPress();
  if (b5.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b5.x, b5.y + 20, 50, 50));
    money -= 50;
  }
  b6.buttonPress();
  if (b6.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b6.x, b6.y + 20, 50, 50));
    money -= 50;
  }
  b7.buttonPress();
  if (b7.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b7.x, b7.y + 20, 50, 50));
    money -= 50;
  }
  b8.buttonPress();
  if (b8.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b8.x, b8.y + 20, 50, 50));
    money -= 50;
  }
  b9.buttonPress();
  if (b9.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b9.x, b9.y + 20, 50, 50));
    money -= 50;
  }
  b10.buttonPress();
  if (b10.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b10.x, b10.y + 20, 50, 50));
    money -= 50;
  }
  b11.buttonPress();
  if (b11.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b11.x, b11.y + 20, 50, 50));
    money -= 50;
  }
  b12.buttonPress();
  if (b12.isPressed == true && money >= 50) {
    barrierList.add(new Barrier(b12.x, b12.y + 20, 50, 50));
    money -= 50;
  }
}

/*********************
 *Aryan Kotwal*
**
 *  Pong with Computer   *
 **************************/


int ballX = 400;
int ballY = 400;
float ballXVelocity = 3;
float ballYVelocity = 3;

//These are the paddle bounce variables
int paddleLeftY = 400; 
int paddleRightY = 400;

int score = 0;
int score2 = 0;
float ballSpeed = 0;
boolean paddleLeftUp, paddleLeftDown, paddleRightUp, paddleRightDown, isBallMoving, isMovePaddleTrue;
float ballAngle = 0;
color bgcolour = #000000;

void setup() {
  size(800, 800);
  rectMode(CENTER);
  textSize(32);
  setBallSpeeds();
}

void draw() {
  background(bgcolour);
  reset();
  drawBall();
  isBallMoving();
  checkBallHitEdges();
  drawPaddles();
  movePaddles();
  checkBallHitPaddle();
  Points();
  drawScore();
  computerPlayer();
  println(score);
}

//This draws the paddle
void drawPaddles() {
  rect(50, paddleLeftY, 50, 100);
  rect(750, paddleRightY, 50, 100);
}


//This draws the score
void drawScore() {
  text("Player 1: " + score, 50, 50);
  text("Player 2: " + score2, 500, 50);
}

//This draws the ball
void drawBall() {
  ellipse(ballX, ballY, 30, 30);
}

//This moves the ball
void isBallMoving() {
  if (isBallMoving==true) {
    ballX = ballX + (int)ballXVelocity;
    ballY = ballY + (int)ballYVelocity;
  }
}

//This checks if the ball is hitting edges
void checkBallHitEdges() {
  if (ballX + 15 > width) {
    ballXVelocity *= -1;
  }
  if (ballX - 15 < 0) {
    ballXVelocity *= -1;
  }
  if (ballY + 15 > height) {
    ballYVelocity *= -1;
  }
  if (ballY - 15 < 0) {
    ballYVelocity *= -1;
  }
}

//This is the reset ball to original position
void reset () {
  if (ballX>780 || ballX<15 ) {
    isBallMoving=false;

    int ballRight = ballX + 15;
    int ballLeft = ballX - 15;
    int r= (int) random(2);
    if (ballRight>780) {

      if ( r==0) {
        ballXVelocity = -3;
        ballYVelocity = 3;
      }
      if ( r==1) {
        ballXVelocity = 3;
        ballYVelocity = -3;
      }
    }
    if (ballLeft<15) {

      if ( r==0) {
        ballXVelocity = -3;
        ballYVelocity = 3;
      }
      if ( r==1) {
        ballXVelocity = 3;
        ballYVelocity = -3;
      }
    }


    if (isBallMoving==false) {
      bgcolour = #AA0000;
      paddleLeftY=400;
      paddleRightY=400;
      ballX=400;
      ballY=400;
    }
  }
}

//This checks if the ball is hitting the paddles
void checkBallHitPaddle() {
  int ballRight = ballX + 15;
  int ballLeft = ballX - 15;
  int ballDown = ballY + 15;
  int ballTop = ballY - 15;
  int paddleRightL = 700;
  int paddleRightD = paddleRightY + 50;
  int paddleRightT = paddleRightY - 50;
  int paddleLeftR = 100;
  int paddleLeftD = paddleLeftY+ 50;
  int paddleLeftT = paddleLeftY - 50;

  if (ballRight -20 > paddleRightL && ballDown > paddleRightT && ballTop < paddleRightD) {
    ballSpeed++;
    ballXVelocity = (float)(-(Math.cos(ballAngle)*(float)ballSpeed));
  }
  if (ballLeft +20 < paddleLeftR && ballDown > paddleLeftT && ballTop < paddleLeftD) {
    ballSpeed++;
    ballXVelocity = (float)((Math.cos(ballAngle)*(float)ballSpeed));
  }
  if (ballYVelocity > 0) {
    ballYVelocity = (float)((Math.sin(ballAngle)*(float)ballSpeed));
  } else {
    ballYVelocity = -(float)((Math.sin(ballAngle)*(float)ballSpeed));
  }
}

//This moves the paddle
void movePaddles() {
  boolean isMovePaddleTrue=true;
  if (isMovePaddleTrue) {
    int paddleRightT = paddleRightY - 50;
    int paddleRightD = paddleRightY + 50;
    int paddleLeftT = paddleLeftY - 50;
    int paddleLeftD = paddleLeftY+ 50;

    if (paddleRightUp  && paddleRightT > 0) { // up arrow
      paddleRightY = paddleRightY - 10;// move the right paddle up
    }
    if (paddleRightDown && paddleRightD < 805 ) { // down arrow
      // move the right paddle down
      paddleRightY = paddleRightY + 10;
    }
    if (paddleLeftUp && paddleLeftT > 0) { // w arrow
      // move the left paddle up
      paddleLeftY = paddleLeftY - 10;
    }
    if (paddleLeftDown && paddleLeftD < 805) { // s arrow
      // move the left paddle down
      paddleLeftY = paddleLeftY + 10;
    }
  }
}

//This is the points variable
void Points() {
  int ballRight = ballX + 15;
  int ballLeft = ballX - 15;
  if (ballRight==790) {
    score++;
    setBallSpeeds();
  }
  if (ballLeft<0) {
    score2++;
    setBallSpeeds();
  }
}

//This sets the ball speed
void setBallSpeeds() {
  ballAngle = degrees(60);
  ballSpeed = 5;
  ballXVelocity = (float)((Math.cos(ballAngle)*(float)ballSpeed));
  ballYVelocity = (float)((Math.sin(ballAngle)*(float)ballSpeed));
}

//This controls the computer paddle
void computerPlayer() {
  if (ballY < paddleLeftY -50 && ballX < 400) { // up arrow
    paddleLeftUp = true;
    paddleLeftDown = false;
  } else if (ballY > paddleLeftY + 50  && ballX < 400) { // down arrow
    // move the right paddle down
    paddleLeftDown = true;
    paddleLeftUp = false;
  } else {
    paddleLeftUp = false;
    paddleLeftDown = false;
  }
}


//This is the keypressed variable
void keyPressed() {
  if (keyCode == 38) { // up arrow
    paddleRightUp = true;
  }
  if (keyCode == 40) { // down arrow
    // move the right paddle down
    paddleRightDown = true;
  }
  if (keyCode == 87) { // w arrow
    // move the left paddle up
    paddleLeftUp = true;
  }
  if (keyCode == 83) { // s arrow
    // move the left paddle down
    paddleLeftDown = true;
  }
  if (keyCode == 32) {  // space
    isBallMoving=true;
    bgcolour = #000000;
  }
}

//This is the key released variable
void keyReleased() {
  if (keyCode == 38) { // up arrow
    paddleRightUp = false;
  }
  if (keyCode == 40) { // down arrow
    // move the right paddle down
    paddleRightDown = false;
  }
  if (keyCode == 87) { // w arrow
    // move the left paddle up
    paddleLeftUp = false;
  }
  if (keyCode == 83) { // s arrow
    // move the left paddle down
    paddleLeftDown = false;
  }
}

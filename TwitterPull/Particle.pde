public class Particle {
  float xPos;
  float yPos;
  float Life = 35;
  float originX = width/2;
  float originY = 0;
  float r;
  float g;
  float b;
  
  Particle(float xPos, float yPos, float r, float g, float b) {
    this.yPos = yPos;
    this.xPos = xPos;
    this.r = r;
    this.g = g;
    this.b = b;
  }

  void paint() {
    fill(r, g, b);
    ellipse((width/2)+xPos, 568 + yPos, 10, 10);
    //rect((width/2)+xPos, 568 + yPos, 5, 5);
    //rect(width/2+xPos, 570+yPos, 5, 5);
  }
  void moveMe(){

  }

  boolean timeUp() {
    Life--;
    if (Life<0) {
      return true;
    } else {
      return false;
    }
  }
}
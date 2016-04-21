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
    canvas.fill(r, g, b);
    canvas.ellipse((width/2)+xPos, 568 + yPos, 10, 10);
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

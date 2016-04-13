public class Particle {
  float xPos;
  float yPos;
  float Life = 35;
  float originX = width/2;
  float originY = 0;
  Particle(float xPos, float yPos) {
    this.yPos = yPos;
    this.xPos = xPos;
  }

  void paint() {
    fill(255, 255, 255);
    rect((width/2)+xPos, 568 + yPos, 5, 5);
    if(xPos > originX){
      xPos -= 1; 
    }
    else if(xPos < originX){
      xPos += 1; 
      }
    else{
      xPos += 0; 
    }
    if(yPos < 0){
      yPos-=2;
    }
    //rect(width/2+xPos, 570+yPos, 5, 5);
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
public class Particle {
<<<<<<< HEAD
 float xPos;
 float yPos;
 float Life = 35;
 float Yspeed = 5;
   Particle(float xPos, float yPos){
     this.yPos = yPos;
     this.xPos = xPos;
   }
 
  void paint(){
     fill(255,255,255);
     ellipse(xPos+=1.5,yPos-=Yspeed,60,60);
     rect(width/2+xPos, 570+yPos, 5, 5);
=======
  float xPos;
  float yPos;
  float Life = 35;

  Particle(float xPos, float yPos) {
    this.yPos = yPos;
    this.xPos = xPos;
>>>>>>> display
  }

  void paint() {
    fill(255, 255, 255);
    rect(xPos+=1, yPos-=5, 5, 5);
    rect((width/2)+xPos, 568 + yPos, 5, 5);
    //rect(width/2+xPos, 570+yPos, 5, 5);
  }
<<<<<<< HEAD
  
=======

  boolean timeUp() {
    Life--;
    if (Life<0) {
      return true;
    } else {
      return false;
    }
  }
>>>>>>> display
}

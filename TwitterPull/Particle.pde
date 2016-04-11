public class Particle {
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
  }
  
  boolean timeUp(){
     Life--;
     if (Life<0){
        return true;
     } 
     else {
        return false;
     }
  }
  
}

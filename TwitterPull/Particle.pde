public class Particle {
 float xPos;
 float yPos;
 float Life = 35;
 
   Particle(float xPos, float yPos){
     this.yPos = yPos;
     this.xPos = xPos;
   }
 
  void paint(){
     fill(0,0,0);
     rect(xPos, yPos, 5, 5);
     //rect(width/2+xPos, 570+yPos, 5, 5);
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
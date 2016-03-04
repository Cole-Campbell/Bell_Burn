public class Particle {
 float xPos;
 float yPos;
 float Life = 20;
 
 Particle(float xPos, float yPos){
   this.yPos = yPos;
   this.xPos = xPos;
 }
 
 void paint(){
   fill(255,255,255);
   rect(xPos, yPos, 5, 5);
}
boolean timeUp(){
 Life--;
 if (Life<0){
   return true;
} else {
  return false;
}
}
}
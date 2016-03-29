public class Display {
 float xPos;
 float yPos;
 double lat;
 double lon;
 
   Display(float xPos, float yPos){
     this.yPos = yPos;
     this.xPos = xPos;
   }
 
  void paint(){
     fill(255);
     rect(xPos, yPos, 50, 50);
  }
  
}
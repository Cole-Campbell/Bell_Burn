public class Display {
  float xPos = 50;
  float yPos = 50;
  double latS = -180;
  double latE = -131;
  double lon;
 
  void paint(){
    for(int y=0; y<=10; y++){
      for(int x=0; x<=10; x++){
        noStroke();
        fill(255);
        rect(xPos*x, yPos, 50, 50);
        
        println("Printed " + latS);
      }
    }
  }
}
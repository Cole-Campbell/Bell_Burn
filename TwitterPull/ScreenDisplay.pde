public class Display {
  float xPos=0;
  float yPos=0;
  int w = 0;
  int h = 0;
  double lon;
 
  void paint(){
    fill(255);
    for(int y=0; y<=height; y=y+50){
      for(int x=0; x<=width; x=x+50){
        rect(xPos+x, yPos+y, 50, 50);       
      }
    }
  }
}
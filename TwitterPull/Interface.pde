public class Interface {
 
  int interWidth;
  int interHeight;
  int interXpos;
  int interYpos;
  color bgColor;
  PGraphics graphic;  
  String delString = "DELETE";
  String pauseString = "PAUSE";
  String clickString = "SAVE"; 
  boolean mouseDown = false;
  
  public Interface(int w, int h, int x, int y){
    interWidth = w;
    interHeight = h;
    interXpos = x;
    interYpos = y;
  }
  //Just making some basic shapes, may be better to do some translate here as it isnt automatically adjustable now
  void paint() {
    fill(200,200,200);    
    rect(interXpos, interYpos, interWidth, interHeight);
        
    fill(150,50,50);
    rect(0, height - 50, 100, 50);
    fill(0,0,0);
    text(delString, 20, height - 40, 100, 50);
    
    fill(50,50,90);
    rect(150, height - 50, 100, 50);
    fill(0,0,0);
    text(clickString, 170, height - 40, 100, 50);
    
    fill(50,70,50);    
    rect(300, height - 50, 100, 50);
    fill(0,0,0);
    text(pauseString, 320, height - 40, 100, 50);    
  }
}
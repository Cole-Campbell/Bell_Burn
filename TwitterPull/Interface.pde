public class Interface {
  
  
  /* The interface is the menu. This class just draws the buttons, 
      in the Handler class, we have to code for each button */
      
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

  public Interface(int w, int h, int x, int y) {
    interWidth = w;
    interHeight = h;
    interXpos = x;
    interYpos = y;
  }
  
  void paint() {
    canvas.fill(200, 200, 200);    
    canvas.rect(interXpos, interYpos, interWidth, interHeight);

    canvas.fill(150, 50, 50);
    canvas.rect(0, height - 50, 100, 50);
    canvas.fill(0, 0, 0);
    canvas.text(delString, 20, height - 40, 100, 50);

    canvas.fill(50, 50, 90);
    canvas.rect(150, height - 50, 100, 50);
    canvas.fill(0, 0, 0);
    canvas.text(clickString, 170, height - 40, 100, 50);

    canvas.fill(50, 70, 50);    
    canvas.rect(300, height - 50, 100, 50);
    canvas.fill(0, 0, 0);
    canvas.text(pauseString, 320, height - 40, 100, 50);
  }
}

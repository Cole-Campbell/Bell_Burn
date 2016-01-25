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
  void paint() {
    fill(200,200,200);    
    rect(interXpos, interYpos, interWidth, interHeight);
    
    
    fill(150,50,50);
    rect(50, 550, 100, 50);
    fill(0,0,0);
    text(delString, 50, 550, 100, 50);
    
    fill(50,50,90);
    rect(250, 550, 100, 50);
    fill(0,0,0);
    text(pauseString, 250, 550, 100, 50);
    
    fill(50,70,50);    
    rect(450, 550, 100, 50);
    fill(0,0,0);
    text(clickString, 450, 550, 100, 50);
  }
}

void mouseClicked() {
  //CHECK MOUSE POS FOR DELETE BUTTON
  if(mouseX >= 50 && mouseX <= 150 && mouseY >= 550 && mouseY <= 600) {
    println("this works");
    
    XML[] getForDeletion = xmlFile.getChildren("tweet");
       
    for(int i = 0; i < getForDeletion.length; i++) {
         println("Deleting " + i);
         xmlFile.removeChild(getForDeletion[i]);   
         saveXML(xmlFile, "data/storeTweets.xml");
    }
  }
}
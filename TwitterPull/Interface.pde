public class Interface {
 
  int interWidth;
  int interHeight;
  int interXpos;
  int interYpos;
  color bgColor;
  PGraphics graphic;
  
  String delString = "DELETE";
  String pauseString = "SAVE";
  String clickString = "PAUSE";
  
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
  
  //If the mouse isnt over the interface.
  if(mouseY < 550) {
      clickToRefresh = true;    
  }
  
  // DELETE FILES
  // Could maybe change to delete last 50 etc
  // Adds all files to an XML array, loop around and delete them all.
  // Must save at the end or else the XML file wont update.
  if(mouseX >= 50 && mouseX <= 150 && mouseY >= 550 && mouseY <= 600) {   
    XML[] getForDeletion = xmlFile.getChildren("tweet");
       
    for(int i = 0; i < getForDeletion.length; i++) {
         println("Deleting " + i);
         xmlFile.removeChild(getForDeletion[i]);   
         saveXML(xmlFile, "data/storeTweets.xml");
    }
  }
  
  if(mouseX >= 250 && mouseX <= 350 && mouseY >= 550 && mouseY <= 600) {
        println("saving...");
        saveXML(xmlFile, "data/storeTweets.xml");
        getNewTweets();
        println("...saved");
  }

  if(mouseX >= 450 && mouseX <= 550 && mouseY >= 550 && mouseY <= 600) {
      println("paused");
      tweetsOnOffSwitch = tweetsOnOffSwitch * -1;
  }
}

void getNewTweets() {
  try {
    //Try to get tweets here
    GeoLocation dubLoc = new GeoLocation(53.344104,-6.2674937); //set location for dublin
    
    Query query = new Query();
    query.count(100); //Returns 100 searches per page
    
    query.setGeoCode(dubLoc, 20, Query.Unit.valueOf("mi"));  //Search for tweets by people who have set dublin as their location. 20mi radius
        
    QueryResult result = twitter.search(query);
    tweets = result.getTweets();
        
    println("Tweets refreshed");
  }
  catch (TwitterException te) {
    // Deal with the case where we cant get them here 
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}
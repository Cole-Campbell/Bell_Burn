//This is the get tweet function

void saveTweets() {
    if(mouseX >= 250 && mouseX <= 350 && mouseY >= 550 && mouseY <= 600) {
        println("saving...");
        saveXML(xmlFile, "data/storeTweets.xml");
        println("...saved");
  }
}

void pauseTweets(){
  if(mouseX >= 450 && mouseX <= 550 && mouseY >= 550 && mouseY <= 600) {
      println("paused");
      tweetsOnOffSwitch = tweetsOnOffSwitch * -1;
  }
}

void deleteTweets() {
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
}
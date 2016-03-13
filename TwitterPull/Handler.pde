

void saveTweets() {
    if(mouseX >= 170 && mouseX <= 270 && mouseY >= height - 50 && mouseY <= height) {
        println("saving...");
        saveXML(xmlFile, saveXml);
        println("...saved");
  }
}

void pauseTweets(){
  if(mouseX >= 320 && mouseX <= 420 && mouseY >= height - 50 && mouseY <= height) {
      println("paused");
      tweetsOnOffSwitch = tweetsOnOffSwitch * -1;
  }
}

void deleteTweets() {
  // DELETE FILES
  // Could maybe change to delete last 50 etc
  // Adds all files to an XML array, loop around and delete them all.
  // Must save at the end or else the XML file wont update.
  if(mouseX >= 0 && mouseX <= 150 && mouseY >= height - 50 && mouseY <= height) {   
    XML[] getForDeletion = xmlFile.getChildren("tweet");
       
    for(int i = 0; i < getForDeletion.length; i++) {
         println("Deleting " + i);
         xmlFile.removeChild(getForDeletion[i]);   
         saveXML(xmlFile, saveXml);
    }
  }
}


void mouseClicked() {
  //Demo interface click handlers
  if(tweetSetDemo == true) {
      deleteTweets(); // Call the delete function from the Handler
      saveTweets();// Call the saveTweets function from the Handler
      pauseTweets();// Call the pauseTweets function from the Handler
  }

  //Activate the Demo version.
  if (mouseX >= 0 && mouseX <= width && mouseY >= 00 && mouseY <= 50) {
    if (tweetSetDemo == false) {
      tweetSetDemo = true;
    }
  }
  //Activate the Live version
  if (mouseX >= 0 && mouseX <= width && mouseY >= 100 && mouseY <= 150) {
    if (tweetSetPlay == false) {
      tweetSetPlay = true;
    }
  }
  //Activate the Play version
  if (mouseX >= 0 && mouseX <= width && mouseY >= 200 && mouseY <= 250) {
    if (tweetSetPlay == false) {
      tweetSetPlay = true;
    }
  }
  //Go back to main menu
  if (mouseX >= width - 100 && mouseY >= height - 50) {
      tweetSetPlay = false;
      tweetSetDemo = false;
      tweetSetLive = false;
  } 
}

//Have set a drag function for arranging the cities on the map
//https://gist.github.com/shinaisan/2390346 referenced this piece doing it.

void mousePressed() {
  if (dublin.mouseOver(mouseX, mouseY)) {
    dublin.mousePressed();
  }
}

void mouseReleased() {
  dublin.mouseReleased();
}
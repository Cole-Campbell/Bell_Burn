

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
  deleteTweets(); // Call the delete function from the Handler
  saveTweets();// Call the saveTweets function from the Handler
  pauseTweets();// Call the pauseTweets function from the Handler

  //Activate the Demo version.
  if (mouseX >= 0 && mouseX <= width && mouseY >= 00 && mouseY <= 50) {
    if (tweetSetDemo == false) {
      tweetSetDemo = true;
      println("This works!!");
    }
  }

  //Activate the Live version
  if (mouseX >= 0 && mouseX <= width && mouseY >= 100 && mouseY <= 150) {
    if (tweetSetPlay == false) {
      tweetSetPlay = true;
      println("This works!!");
    }
  }

  //Activate the Play version
  if (mouseX >= 0 && mouseX <= width && mouseY >= 200 && mouseY <= 250) {
    if (tweetSetPlay == false) {
      tweetSetPlay = true;
      println("This works!!");
    }
  }
}

//Have set a drag function for arranging the cities on the map
//https://gist.github.com/shinaisan/2390346 referenced this piece doing it.
/*
void mousePressed() {
  if (dublin.mouseOver(mouseX, mouseY)) {
    dublin.mousePressed();
  }
}

void mouseReleased() {
  dublin.mouseReleased();
}*/

void timer() {
  if(frameCount % 30 == 1) {
     //println("Counting down from ..." + timerCount);
     timerCount--; 
     if(timerCount == 0) {
       incrementMe.add(Calendar.MINUTE, 15);
       String whatTime = incrementMe.getTime() + " ";
       println("Current time = " + whatTime);
       String strHH = whatTime.substring(11,13);
       String strMM = whatTime.substring(14,16);
       
       curHH = Integer.parseInt(strHH);
       curMM = Integer.parseInt(strMM);
       
       println("Current Hour = " + curHH);
       println("Current Min = " + curMM);
       timerCount = 6;  }
  }  
}
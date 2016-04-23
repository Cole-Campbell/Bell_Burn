

void saveTweets() {
  if (tweetSetDemo == true) {
    if (mouseX >= 170 && mouseX <= 270 && mouseY >= height - 50 && mouseY <= height) {
      println("saving...");
      saveXML(xmlFile, saveXml);
      println("...saved");
    }
  }
  if (tweetSetLive == true) {
    if (mouseX >= 170 && mouseX <= 270 && mouseY >= height - 50 && mouseY <= height) {
      println("saving...");
      saveXML(xmlLive, liveXml);
      println("...saved");
    }
  }
}

void pauseTweets() {
  if (mouseX >= 320 && mouseX <= 420 && mouseY >= height - 50 && mouseY <= height) {
    println("paused");
    tweetsOnOffSwitch = tweetsOnOffSwitch * -1;
  }
}

void deleteTweets() {
  // DELETE FILES
  // Adds all files to an XML array, loop around and delete them all.
  // Must save at the end or else the XML file wont update.

  if (mouseX >= 0 && mouseX <= 150 && mouseY >= height - 50 && mouseY <= height) {   
    if (tweetSetDemo == true) {
      XML[] getForDeletion = xmlFile.getChildren("tweet");

      for (int i = 0; i < getForDeletion.length; i++) {
        println("Deleting " + i);
        xmlFile.removeChild(getForDeletion[i]);   
        saveXML(xmlFile, saveXml);
      }
    }
    if (tweetSetLive == true) {
      XML[] getForDeletion = xmlLive.getChildren("tweet");

      for (int i = 0; i < getForDeletion.length; i++) {
        println("Deleting " + i);
        xmlLive.removeChild(getForDeletion[i]);   
        saveXML(xmlLive, liveXml);
      }
    }
  }
}


void mouseClicked() {
  //Demo interface click handlers
  if (tweetSetDemo == true || tweetSetLive == true) {
    deleteTweets(); // Call the delete function from the Handler
    saveTweets();// Call the saveTweets function from the Handler
    pauseTweets();// Call the pauseTweets function from the Handler
  }

  //Activate the Demo version.
  if (mouseX >= 0 && mouseX <= width && mouseY >= 00 && mouseY <= 50) {
    if (tweetSetDemo == false) {
      tweetSetDemo = true;
      getTweets();
    }
  }
  //Activate the Live version
  if (mouseX >= 0 && mouseX <= width && mouseY >= 100 && mouseY <= 150) {
    if (tweetSetLive == false) {
      tweetSetLive = true;
      getTweets();
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

void timer() {
  if (frameCount % 25 == 1) {
    //println("Counting down from ..." + timerCount);
    timerCount--; 
    if (timerCount == 0) {
      timeIncreased = true;
      incrementMe.add(Calendar.MINUTE, -30);
      String whatTime = incrementMe.getTime() + " ";
      //println("Current time = " + whatTime);
      String strHH = whatTime.substring(11, 13);
      String strMM = whatTime.substring(14, 16);

      curHH = Integer.parseInt(strHH);
      curMM = Integer.parseInt(strMM);

      //println("Current Hour = " + curHH);
      //println("Current Min = " + curMM);
      timerCount = 6;
    }
  }
}


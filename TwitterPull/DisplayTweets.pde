void displayTweets() {
  //Colour variable which will change depending on the number of tweets in an area
  float colour = 200;
  //display.paint();
  for (int a = 0; a < cities.size(); a++) {
    City myCity = cities.get(a);
    //myCity.makeCity();
  }

  for (int y = 0; y<=height/10; y++) {
    for (int x = 0; x<=width; x++) {
      //xPosition, yPosition, start Latitude, end latitude, start longitude, end longitude, colour
      display.add(new Display(10*x, 10*y, 200, 200, 200, 200, colour));
    }
  }
  fill (255);
  //Load up all the tweets from the XML file.
  XML[] tweetList = xmlFile.getChildren("tweet");
  //We only need to do this once a second, 
  if (frameCount%30==1) {
    //We need to extract all the tweets we have saved
    for (int t=0; t<tweetList.length; t++) {
      //Store the tweets attributes
      String tweetDate = tweetList[t].getString("tweet-date");
      //println(tweetDate);
      String tweetCity = tweetList[t].getString("city-name");
      Double tweetLat = tweetList[t].getDouble("latitude");
      Double tweetLong = tweetList[t].getDouble("longitude");
      String tweetDateString = tweetDate.substring(11, 19) + " ";

      //Grab the hour and minutes, convert them to integers
      String tweetStrHH = tweetDate.substring(11, 13);
      String tweetStrMM = tweetDate.substring(14, 16);
      int tweetHH = Integer.parseInt(tweetStrHH);
      int tweetMM = Integer.parseInt(tweetStrMM);

      //println(tweetDateString);

      //Comparing Tweet Lat/Long to the squares to then place them appropriatly\
      for (int x=0; x<=width-1; x++) {
        /*if (tweetLat>display.latS && tweetLat<display.latE) {
         println();
         }*/
      }

      //We then need to compare them.
      //So go through each city
      for (int j = 0; j < cities.size(); j++) { 
        City whichCity = cities.get(j);
        
        //Goes through all squares in the display to compare them below
        for (int i = 0; i < display.size(); i++) {
          Display whichSquare = display.get(i);
          //check which city we are currently on
          if (tweetCity.equals(whichCity.cityName)) {
            if (tweetHH - curHH == 0) {
              if (curMM - tweetMM <= 15) {
                if (tweetLat>=whichSquare.startLat && tweetLat<= whichSquare.endLat) {
                  whichSquare.colour = 255;
                }


                /*double differenceLat = whichCity.longitude - tweetLat;           
                 double differenceLong = whichCity.latitude - tweetLong;
                 
                 float b = (float)differenceLong;
                 float d = (float)differenceLat;
                 
                 b = b* longPix;
                 d = d*latPix;*/
              }
            }
          }
        }
      }
    }
  }
}

void timer() {
  if (frameCount % 30 == 1) {
    //println("Counting down from ..." + timerCount);
    timerCount--; 
    if (timerCount == 0) {
      incrementMe.add(Calendar.MINUTE, 15);
      String whatTime = incrementMe.getTime() + " ";
      println("Current time = " + whatTime);
      String strHH = whatTime.substring(11, 13);
      String strMM = whatTime.substring(14, 16);

      curHH = Integer.parseInt(strHH);
      curMM = Integer.parseInt(strMM);

      println("Current Hour = " + curHH);
      println("Current Min = " + curMM);
      timerCount = 6;
    }
  }
}
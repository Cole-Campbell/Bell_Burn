void displayTweets() {
  //Load up all the tweets from the XML file.
  XML[] tweetList = xmlFile.getChildren("tweet");
  //We only need to do this once a second, 
  if (timeIncreased == true) {
    //We need to extract all the tweets we have saved
    for (int j = 0; j < cities.size (); j++) {
      City whichCity = cities.get(j);
      float counter = 0; 

      for (int t=0; t<tweetList.length; t++) {
        //Store the tweets attributes
        String tweetDate = tweetList[t].getString("tweet-date");
        String tweetCity = tweetList[t].getString("city-name");
        Double tweetLat = tweetList[t].getDouble("latitude");
        Double tweetLong = tweetList[t].getDouble("longitude");
        String tweetDateString = tweetDate.substring(11, 19) + " ";

        //Grab the hour and minutes, convert them to integers
        String tweetStrHH = tweetDate.substring(11, 13);
        String tweetStrMM = tweetDate.substring(14, 16);
        int tweetHH = Integer.parseInt(tweetStrHH);
        int tweetMM = Integer.parseInt(tweetStrMM);
        
        whichCity.radius = counter;

        //Goes through all squares in the display to compare them below

        //Check which city we are currently on

        if (tweetCity.equals(whichCity.cityName)) {
          if (tweetHH - curHH == 0) {
            if (curMM - tweetMM <= 1) {
              counter = counter + .04;
              println(tweetDate);
              println(whichCity.radius);
            }
          }
        }
      }
    }
    timeIncreased = false;
  }
}


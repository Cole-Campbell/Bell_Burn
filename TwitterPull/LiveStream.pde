
class LiveRun implements Runnable {
  public void run() {
    if (startThread == true) {
      //We need to cycle through the tweets in the tweetList arrayList
      currentTweet = currentTweet +1;
      //For live stream, we dont want to go onto the next page, so just reset to 0.
      //So when currentTweet is 100, reset to 0, call getNewTweets 
      if (currentTweet==100) {
        currentTweet=0;
        //Loop through the cities array and get each city
        for (int j = 0; j < cities.size(); j++) {           
          City myCity = cities.get(j);            
          myCity.makeCity();
          myCity.getNewTweets();

          //We then loop through each cities tweets.
          for (int k = 0; k < myCity.tweets.size(); k++) {
            //We get the tweets from each city.
            Status status = myCity.tweets.get(k);
            User user = status.getUser();

            println(myCity.cityName + " " + myCity.tweets.size());

            //Running this piece of code returns when the tweets were created. 
            String storeDate = "" + status.getCreatedAt();           
            //The id is in the data type LONG and needs to be converted to a string
            long idLong = status.getId();
            String longString = "" + idLong;
            String searchWord = status.getText();        
            //We need to load up the XML file and check if the tweets already exist
            XML[] liveList = xmlLive.getChildren("tweet");
            boolean tweetExists = false;

            for (int t=0; t<liveList.length; t++) {
              String tweetID = liveList[t].getString("tweet-id");
              if (tweetID.equals(longString)) {
                tweetExists = true;
              }
            }
            if (tweetExists == false) {
              //if(searchWord.contains("Tweetset")){            
              //  tts.speak(searchWord);
              //}

              //For saving to XML
              //Load up with the data we want from the status object
              //ID, Author, Date and the CityObjects name.
              XML newChild = xmlLive.addChild("tweet");  
              newChild.setContent(status.getText());
              newChild.setString("tweet-id", longString);
              newChild.setString("tweet-date", storeDate);
              newChild.setString("city-name", myCity.cityName);


              //We want to check if there is a GeoLocation attached to a tweet.
              if (status.getGeoLocation() != null) {
                GeoLocation tweetLoc = status.getGeoLocation();
                double longitude = tweetLoc.getLongitude();
                double latitude = tweetLoc.getLatitude();
                println(longitude); 
                println(latitude);
                newChild.setDouble("longitude", longitude);
                newChild.setDouble("latitude", latitude);
              }

              //Unlike in the other version, the tweets are coming straight from a city and pinging towards the top             
              shootingParticles.add(new Particle(myCity.xPos, myCity.yPos, myCity.r, myCity.g, myCity.b));
            } else {
              println("Sorry, this tweet already exists!");
            }
          }
        }
      }
      startThread = true;
    }
  }
}

/*void liveStream() {
 
 //for (int j = 0; j < shootingParticles.size(); j++) { 
 //    Particle aParticle = shootingParticles.get(j);
 //    aParticle.paint();
 //}
 if (tweetsOnOffSwitch == 1) {
 
 //We need to cycle through the tweets in the tweetList arrayList
 currentTweet = currentTweet +1;
 //For live stream, we dont want to go onto the next page, so just reset to 0.
 //So when currentTweet is 100, reset to 0, call getNewTweets 
 if (currentTweet==100) {
 currentTweet=0;
 //Loop through the cities array and get each city
 for (int j = 0; j < cities.size(); j++) {           
 City myCity = cities.get(j);            
 myCity.makeCity();
 myCity.getNewTweets();
 
 //We then loop through each cities tweets.
 for (int k = 0; k < myCity.tweets.size(); k++) {
 //We get the tweets from each city.
 Status status = myCity.tweets.get(k);
 User user = status.getUser();
 
 println(myCity.cityName + " " + myCity.tweets.size());
 
 //Running this piece of code returns when the tweets were created. 
 String storeDate = "" + status.getCreatedAt();           
 //The id is in the data type LONG and needs to be converted to a string
 long idLong = status.getId();
 String longString = "" + idLong;
 String searchWord = status.getText();        
 //We need to load up the XML file and check if the tweets already exist
 XML[] liveList = xmlLive.getChildren("tweet");
 boolean tweetExists = false;
 
 for (int t=0; t<liveList.length; t++) {
 String tweetID = liveList[t].getString("tweet-id");
 if(tweetID.equals(longString)){
 tweetExists = true;
 }
 }
 if(tweetExists == false) {
 //if(searchWord.contains("Tweetset")){            
 //  tts.speak(searchWord);
 //}
 
 //For saving to XML
 //Load up with the data we want from the status object
 //ID, Author, Date and the CityObjects name.
 XML newChild = xmlLive.addChild("tweet");  
 newChild.setContent(status.getText());
 newChild.setString("tweet-id", longString);
 newChild.setString("tweet-date", storeDate);
 newChild.setString("city-name", myCity.cityName);
 
 
 //We want to check if there is a GeoLocation attached to a tweet.
 if (status.getGeoLocation() != null) {
 GeoLocation tweetLoc = status.getGeoLocation();
 double longitude = tweetLoc.getLongitude();
 double latitude = tweetLoc.getLatitude();
 println(longitude); 
 println(latitude);
 newChild.setDouble("longitude", longitude);
 newChild.setDouble("latitude", latitude);
 }
 
 //Unlike in the other version, the tweets are coming straight from a city and pinging towards the top             
 shootingParticles.add(new Particle(myCity.xPos, myCity.yPos, myCity.r, myCity.g, myCity.b));
 }
 else{
 println("Sorry, this tweet already exists!");
 }
 }
 }
 }
 }
 startThread = false;
 }*/
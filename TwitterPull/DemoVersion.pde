

void demoVersion() {
    
    myInterface.paint();
    image(world, 0, 0);
    
    //The pause button will change tweetsOnOffSwitch to 0.
    if (tweetsOnOffSwitch == 1) {
      
      //We need to cycle through the tweets in the tweetList arrayList
      currentTweet = currentTweet +1;
      //when currentTweet is 100, we want to go onto the next page
      if (currentTweet==100) {
        //We need to change nextPage to true, so when we call getNewTweets, it calls the nextQuery.
        nextPage=true;
        currentTweet=0;
     
        //Loop through the cities array and get each city
        for (int j = 0; j < cities.size(); j++) { 
          
          City myCity = cities.get(j);            
          myCity.makeCity();
          myCity.getNewTweets();
          println("calling this");
          
          //We then loop through each cities tweets.
          for (int k = 0; k < myCity.tweets.size(); k++) {
            
            Status status = myCity.tweets.get(k);
            User user = status.getUser();

            println(myCity.cityName + " " + myCity.tweets.size());

            //Running this piece of code returns when the tweets were created. 
            String storeDate = "" + status.getCreatedAt();           
            //The id is in the data type LONG and needs to be converted to a string
            long idLong = status.getId();
            String longString = "" + idLong;


            //This piece is nearly obsolete, its for displaying a tweet on screen
            fill(200);
            text(status.getText(), 100, 100, 300, 200);
            text(user.getName(), 200, 300, 300, 200);
            text(longString, 300, 300, 300, 200);
            println(status.getCreatedAt());

            //For saving to XML
            //Load up with the data we want from the status object
            //ID, Author, Date and the CityObjects name.
            XML newChild = xmlFile.addChild("tweet");  
            newChild.setContent(status.getText());
            newChild.setString("tweet-id", longString);
            newChild.setString("tweet-name", user.getName());
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
          }
        }
      }
      else{
        nextPage=false;
      }
   }
}
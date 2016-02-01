//This is the get tweet function
void getNewTweets() {
  try {
    //Try to get tweets here

    // UPDATE 2/1/2016
    //Added in an extra step here for future editing. Basically we set the citys Name, Longitude, Latitude
    //Then add the long and lat to the geoLocation.
    //This is first steps towards generating the graphics.
    //Use the City class to generate where the lights originate from?
    //In the draw function have maybe dublin.paint() and it draws the circle
    //Also make a drag function so we can place the cities where they belong
    
    dublin = new City("Dublin",53.344104,-6.2674937,200,100,50);
    GeoLocation dubLoc = new GeoLocation(dublin.longitude,dublin.latitude); //set location for dublin
    
    
    //The Query is how we want our results to come back
    //Basically calling it the type of search we want
    //When we search for the tweets we pass in this query    
    Query query = new Query();
    query.count(100); //Returns 100 searches per page (max 100)
    
    //Here we define what type of search we want
    //We pass it our geoLocation, the distance, and we must set if its "km" or "mi"
    query.setGeoCode(dubLoc, 20, Query.Unit.valueOf("mi"));
    
    //This will only run once at the start of the program
    //We get the first set of results from our query
    //We create a QueryResult and name it result in the main file
    //We then search for our QueryResult using the parameters set above.
    //We put the tweets it retrieved into the tweets ArrayList created in the main
    if(nextPage == false) {    
      result = twitter.search(query);
      tweets = result.getTweets();
      println("Tweets refreshed");
    }


    
    //This will be called after the first call, this will then be called indefinitely
    //Use the query created above and pass it the nextQuery call.
    if(nextPage == true) {
        pageNum = pageNum + 1;
        query = result.nextQuery();
        result = twitter.search(query);
        tweets = result.getTweets();
        println("Page " + pageNum);
        nextPage = false;
    }

  }
  catch (TwitterException te) {
    // Deal with the case where we cant get them here 
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}

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
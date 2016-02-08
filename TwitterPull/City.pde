public class City {
   
  String cityName;
  double longitude;
  double latitude;
  float xPos;
  float yPos;
  float radius;
  List<Status> tweets;
   
  //Need to pass these arguments when making a city
  //City Name
  //Longitude
  //Latitude
  //circle x
  //circle y
  //circle radius
  public City(String w, double lo, double la, float x, float y, float radius){
    
    this.cityName = w;
    this.longitude = lo;
    this.latitude = la;
    this.xPos = x;
    this.yPos= y;
    this.radius = radius;
  }

  void makeCity() {
    
      fill(255,255,255);
      ellipse(xPos,yPos,radius,radius);
      
                   
        
  }
  
  
  boolean moving = false;

  void mousePressed() {
      moving = true;
  }
  
  void mouseReleased() {
      moving = false;
  }

  boolean mouseOver(int mx, int my) {
      return ((xPos - mx)*(xPos - mx) + (yPos - my)*(yPos - my)) <= radius*radius;
  }

  void move() {
      if (moving) {
          this.xPos = mouseX;
          this.yPos = mouseY;
      }
  }
  //http://stackoverflow.com/questions/16730364/add-arraylist-to-another-arraylist-in-java
  
  //UPDATE 2/7/2016
  //  Im moving this here, I wanna try adding another city, and gettng the tweets of the two at the same time
  //  We can then make two citys and pass it the parameters we need to call the getNewTweets for the specific location.
  //  Can try then to make an arrayList with each city and use a for loop to call each getNewTweets.
  //  I think we might run into some issues with how we save to XML here that will have to be looked at */
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

    GeoLocation coors = new GeoLocation(longitude,latitude); //set location for dublin
    
    
    //The Query is how we want our results to come back
    //Basically calling it the type of search we want
    //When we search for the tweets we pass in this query    
    Query query = new Query();
    query.count(100); //Returns 100 searches per page (max 100)
    
    //Here we define what type of search we want
    //We pass it our geoLocation, the distance, and we must set if its "km" or "mi"
    query.setGeoCode(coors, 20, Query.Unit.valueOf("mi"));
    
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
        println(cityName + "Page " + pageNum);
        nextPage = false;
    }
    
    Status status = tweets.get(currentTweet);
        //I found this part a little confusing
        //First we get the current tweet
        //We store it in a status object,
        //Then we can make a User object, then put the status.user property(its in JSON) into that object
        //then we can get different attributes associated with it.
        User user = status.getUser();
        println(tweets.size());
        /*
        GeoLocation tweetLoc = status.getGeoLocation();
        double longitude = tweetLoc.getLongitude();
        println(longitude);
        */
        
        //Running this piece of code returns when the tweets were created. 
        //Will store this in XML as well. 
        String storeDate = "" + status.getCreatedAt();
        
        //Ok, so tweets come up, but seems like some are repeated.
        //In order to eliminate these from being saved to the XML file and being false data
        //One possible solution is we must get each ones id, then compare it to the rest of the IDs.
        //And only add it to the XML file if the ID is unique. For loop, load XML, check then add or delete.
        
        //The id is in the data type LONG
        //In order to convert to string I had to use concatenation. 
        long idLong = status.getId();
        String longString = "" + idLong;
        fill(200);
        
        //Space switches the number
        //Control to turn it on and off
        if(tweetsOnOffSwitch == 1) {
           text(status.getText(), 100, 100, 300, 200);
           text(user.getName(), 200, 300, 300, 200);
           text(longString,300,300,300,200);
           println(status.getCreatedAt());
           delay(2);
        }
        
        //Declaring a new XML object to add to the file  
        //Set its content to == the tweet text
        
        XML newChild = xmlFile.addChild("tweet");  
        newChild.setContent(status.getText());
        //give the tweet an ID attribute
        newChild.setString("tweet-id", longString);
        //give the tweet a userName attribute
        newChild.setString("tweet-name", user.getName());
        //give the tweet a date attribute
        newChild.setString("tweet-date", storeDate);
        //Have cleaned this up and removed the old method i was using.
        //Not sure if theres other pieces we should add.

  }
  catch (TwitterException te) {
    // Deal with the case where we cant get them here 
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}
void callGet() {
    if (currentTweet >= tweets.size()) {
      currentTweet = 0;
      nextPage = true;
      getNewTweets();
    }
}
}
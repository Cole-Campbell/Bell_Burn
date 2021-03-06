public class City {
   
  String cityName;
  double longitude;
  double latitude;
  float xPos;
  float yPos;
  float radius;
  float r;
  float g;
  float b;
  List<Status> tweets;
  QueryResult result;
  //Need to pass these arguments when making a city
  //City Name
  //Longitude
  //Latitude
  //circle x
  //circle y
  //circle radius
  public City(String w, double lo, double la, float x, float y, float radius, float r, float g, float b){
    
    this.cityName = w;
    this.longitude = lo;
    this.latitude = la;
    this.xPos = x;
    this.yPos= y;
    this.radius = radius;
    this.r = r;
    this.g = g;
    this.b = b;
    
  }

  void makeCity() {   
      canvas.fill(r,g,b);
      //canvas.ellipse(xPos,500,200,200);    
      canvas.ellipse((width/2)+xPos, 516 + yPos, radius, radius);   
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
    println("Initial state of boolean " + nextPage);
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
    if(tweetSetLive == true){
      query.count(10);
    }
    else{
      query.count(100); //Returns 100 searches per page (max 100)
    }
    //Here we define what type of search we want
    //We pass it our geoLocation, the distance, and we must set if its "km" or "mi"
    query.setGeoCode(coors, 2, Query.Unit.valueOf("mi"));
    
    //This will only run once at the start of the program
    //We get the first set of results from our query
    //We create a QueryResult and name it result
    //We then search for our QueryResult using the parameters set above.
    //We put the tweets it retrieved into the tweets ArrayList created by the city class
    if(nextPage == false) {    
      result = twitter.search(query);
      tweets = result.getTweets();
      println("Tweets refreshed");
    }
    
    //This will be called after the first call, this will then be called indefinitely
    //Use the query created above and pass it the nextQuery call.
    if(nextPage == true) {
        pageNum = pageNum + 1;
        if(result.hasNext()){
          query = result.nextQuery();
          result = twitter.search(query);
          tweets = result.getTweets();
          println(cityName + "Page " + pageNum);
          //nextPage = false;
        }
        else{
          println("NOPE");
          println("NOPE");
          println("NOPE");
        }
    }
    
    
        
  }
  catch (TwitterException te) {
    // Deal with the case where we cant get them here 
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}
}

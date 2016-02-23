import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import twitter4j.conf.*; 
import twitter4j.*; 
import twitter4j.auth.*; 
import twitter4j.api.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TwitterPull extends PApplet {







Twitter twitter;

PImage world;

//String is not needed anymore, can leave it here for now as a note
//Incase we want to put it back in, pass it through the Query object.
String search = "";

String xml = "storeTweets.xml";
String saveXml = "data/storeTweets.xml";

String tweetCity;

//This keeps track of what tweet we are on and when ready changes nextPage to true
int currentTweet;
boolean nextPage = false;

QueryResult result;
//Arraylist to store the status (the tweet);
List<City> cities;
//List<Status> tweets;

//Going to put in a switch to turn on and off the get tweets function
int tweetsOnOffSwitch = 1;

// To store the XML file location.
XML xmlFile;

Interface myInterface;

int pageNum = 1;

City dublin;
City toronto;

boolean tweetSetDemo = false;
boolean tweetSetLive = false;
boolean tweetSetPlay = false;

public void setup() {

  //fullScreen();
  

  cities = new ArrayList<City>();
  dublin = new City("Dublin", 53.344104f, -6.2674937f, 200, 100, 50);
  toronto = new City("Toronto", 43.6525f, -79.381667f, 400, 200, 50);
  cities.add(dublin);
  cities.add(toronto);

  xmlFile = loadXML(xml);
  world = loadImage("world.png");
  world.resize(800,600);

  //width,height,x,y
  myInterface = new Interface(width, 50, 0, height - 50); //Initiate the interface

  ConfigurationBuilder cb = new ConfigurationBuilder();

  cb.setOAuthConsumerKey(con);
  cb.setOAuthConsumerSecret(conS);
  cb.setOAuthAccessToken(access);
  cb.setOAuthAccessTokenSecret(accessS);

  TwitterFactory tf = new TwitterFactory(cb.build());

  twitter = tf.getInstance();

  dublin.getNewTweets();
  toronto.getNewTweets();

  currentTweet = 0;
}

public void draw() {

  background(0);

  //Turns on the button upon start up
  if (tweetSetDemo == false && tweetSetLive == false && tweetSetPlay == false) {    

    fill(255, 255, 255);
    rect(0, 0, width, 50);
    fill(0, 0, 0);
    text("TweetSet Demo", 0, 0, 300, 200);

    fill(255, 255, 255);
    rect(0, 100, width, 50);
    fill(0, 0, 0);
    text("TweetSet Live", 0, 100, 300, 200);

    fill(255, 255, 255);
    rect(0, 200, width, 50);
    fill(0, 0, 0);
    text("TweetSet Play", 0, 200, 300, 200);
  }


  //Turns on the live tweets version
  if (tweetSetLive == true) {

    liveStream();
  }



  //Turns on the demo version
  if (tweetSetDemo == true) {

    myInterface.paint();

    image(world, 0, 0);

    if (tweetsOnOffSwitch == 1) {

      currentTweet = currentTweet +1;
      println(currentTweet);
      //when currentTweet is 100, we want to go onto the next page
      if (currentTweet==100) {

        nextPage=true;
        currentTweet=0;
      }
      //Need to specify a number so the for loop only calls once
      if (currentTweet == 10) {
        //Loop through the cities array and get each object
        for (int j = 0; j < cities.size(); j++) { 

          City myCity = cities.get(j);

          //The first time we loop through, it will skip this
          //The next time, nextPage will be true, so call the next set of tweets
          //We want to call this for each city          
          if (nextPage == true) {

            myCity.makeCity();
            myCity.getNewTweets();
            delay(500);
            println("calling this");
          }

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
    }

    //For the drag
    dublin.move();
    toronto.move();
  }

  //TweetSet Play
  if (tweetSetPlay == true) {
    int dubLatPix = 400;
    int dubLonPix = 223;
    
    image(world, 0, 0);
    world.resize(800,600);
    //rect(dubLatPix,dubLonPix,5,5);
    fill (0,255,0);

    XML[] tweetList = xmlFile.getChildren("tweet");
    if (frameCount%30==1) {
      for (int t=0; t<tweetList.length; t++) {
        String tweetDate = tweetList[t].getString("tweet-date");
        String tweetCity = tweetList[t].getString("city-name");
        Double tweetLat = tweetList[t].getDouble("latitude");
        Double tweetLong = tweetList[t].getDouble("longitude");
        String tweetDateString = tweetDate.substring(11, 19) + " ";       
      }
    }
    for (int w=0; w<tweetList.length; w++){
          if (tweetCity=="Dublin") {
           
            println(tweetCity);
            
          } else if (tweetCity == "Toronto") {
            
            double localTorLat = 43.7000f;
            double localTorLon = 79.4000f;
            println("This is Toronto");
            fill (150,200,120);
            rect (10, 100, 20, 20);
            fill (150,200,120);
            
          }
        }
      }
}
    
  

public void mouseClicked() {
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
public void mousePressed() {
  if (dublin.mouseOver(mouseX, mouseY)) {
    dublin.mousePressed();
  }
}

public void mouseReleased() {
  dublin.mouseReleased();
}
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

  public void makeCity() {
    
      fill(255,255,255);
      ellipse(xPos,yPos,radius,radius);
      
                   
        
  }
  
  
  boolean moving = false;

  public void mousePressed() {
      moving = true;
  }
  
  public void mouseReleased() {
      moving = false;
  }

  public boolean mouseOver(int mx, int my) {
      return ((xPos - mx)*(xPos - mx) + (yPos - my)*(yPos - my)) <= radius*radius;
  }

  public void move() {
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
  public void getNewTweets() {
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
    }
    
    
        
  }
  catch (TwitterException te) {
    // Deal with the case where we cant get them here 
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}
}
//This is the get tweet function

public void saveTweets() {
    if(mouseX >= 170 && mouseX <= 270 && mouseY >= height - 50 && mouseY <= height) {
        println("saving...");
        saveXML(xmlFile, saveXml);
        println("...saved");
  }
}

public void pauseTweets(){
  if(mouseX >= 320 && mouseX <= 420 && mouseY >= height - 50 && mouseY <= height) {
      println("paused");
      tweetsOnOffSwitch = tweetsOnOffSwitch * -1;
  }
}

public void deleteTweets() {
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
public class Interface {
 
  int interWidth;
  int interHeight;
  int interXpos;
  int interYpos;
  int bgColor;
  PGraphics graphic;
  
  String delString = "DELETE";
  String pauseString = "PAUSE";
  String clickString = "SAVE";
  
  boolean mouseDown = false;
  
  public Interface(int w, int h, int x, int y){
    interWidth = w;
    interHeight = h;
    interXpos = x;
    interYpos = y;
  }
  //Just making some basic shapes, may be better to do some translate here as it isnt automatically adjustable now
  public void paint() {
    fill(200,200,200);    
    rect(interXpos, interYpos, interWidth, interHeight);
        
    fill(150,50,50);
    rect(0, height - 50, 100, 50);
    fill(0,0,0);
    text(delString, 20, height - 40, 100, 50);
    
    fill(50,50,90);
    rect(150, height - 50, 100, 50);
    fill(0,0,0);
    text(clickString, 170, height - 40, 100, 50);
    
    fill(50,70,50);    
    rect(300, height - 50, 100, 50);
    fill(0,0,0);
    text(pauseString, 320, height - 40, 100, 50);
    
    fill(30,90,50);    
    rect(300, height - 50, 100, 50);
    fill(0,0,0);
    text("coming soon...", width - 100, height - 40, 100, 50);
  }
}
/*
REF: https://github.com/yusuke/twitter4j/blob/master/twitter4j-examples/src/main/java/twitter4j/examples/stream/PrintSampleStream.java

Had to remove the classes and make it a void for it to work properly

If you remove one of the @Override then you will get an error 
saying that the function MUST call that function.
*/

public void liveStream() {
  TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
  StatusListener listener = new StatusListener() {
            @Override
            public void onStatus(Status status) {
                System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText() + status.getCreatedAt());
            }

            @Override
            public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
                System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
            }

            @Override
            public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
                System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
            }

            @Override
            public void onScrubGeo(long userId, long upToStatusId) {
                System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
            }

            @Override
            public void onStallWarning(StallWarning warning) {
                System.out.println("Got stall warning:" + warning);
            }
            @Override
            public void onException(Exception ex) {
                ex.printStackTrace();
            }
        };
        //http://twitter4j.org/javadoc/twitter4j/TwitterStream.html 
                
        twitterStream.addListener(listener);
        
        //I reckon here we can use the filter() function here to only get certain tweets,
        //Same as how the query works maybe
        twitterStream.sample();
        delay(20000);
}
public String con = "qTX63Ehu0bnWuJqKSEXeR7hzI";
public String conS = "qlwAYWt9SGtV1rZITQU1i7cevH2GW21tiWNAOIHcIMsHVAXCkK";
public String access = "537618780-TnQbYM3IS88usjTURUFyX2QJTL2kwBZemAqOCQKu";
public String accessS = "CWwSNlbOajW0cxG211yfCOaLS5SYurJGWeoVEUNxiBUYL";
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "TwitterPull" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

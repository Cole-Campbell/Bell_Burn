import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

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
boolean tweetSetPlay = true;

void setup() {

  //fullScreen();
  size(800, 600);

  cities = new ArrayList<City>();
  dublin = new City("Dublin", 53.344104, -6.2674937, 200, 100, 50);
  toronto = new City("Toronto", 43.6525, -79.381667, 400, 200, 50);
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

void draw() {

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
    //println("This is Working!!!");
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
        println(tweetDateString);
      }
    }
  }
    
    //Timer Code to increment time by 30 minutes for each second
    Timer timer = new Timer();
    timer.schedule(new TimerTask(){
      @Override
      void increaseTime(){
        
      }
    }, 60000);
    
    
    
    //Was display code, currently not working or reading the cities
    /*for (int w=0; w<tweetList.length; w++){
          if (tweetCity=="Dublin") {
           
        //String tweetCity = tweetList[t].getString("city-name");    
            
          } else if (tweetCity == "Toronto") {
            
            double localTorLat = 43.7000;
            double localTorLon = 79.4000;
            println("This is Toronto");
            fill (150,200,120);
            rect (10, 100, 20, 20);
            fill (150,200,120);
            
          }
        }
      }*/
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
void mousePressed() {
  if (dublin.mouseOver(mouseX, mouseY)) {
    dublin.mousePressed();
  }
}

void mouseReleased() {
  dublin.mouseReleased();
}
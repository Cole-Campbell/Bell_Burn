import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

PImage world;

Twitter twitter;

//String is not needed anymore, can leave it here for now as a note
//Incase we want to put it back in, pass it through the Query object.
String search = "";

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

void setup() {
  
  
  cities = new ArrayList<City>();
  dublin = new City("Dublin",53.344104,-6.2674937,200,100,50);
  toronto = new City("Toronto",43.6525,-79.381667,400,200,50);
  cities.add(dublin);
  cities.add(toronto);
  
  size(800, 600);
  world = loadImage("world.png");
  
  xmlFile = loadXML("storeTweets.xml");
  
                            //width,height,x,y
  myInterface = new Interface(width,50,0,height - 50); //Initiate the interface
  
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
  if(tweetSetDemo == false && tweetSetLive == false) {    
    
      fill(255,255,255);
      rect(0,0,width,50);
      fill(0,0,0);
      text("TweetSet Demo", 0, 0, 300, 200);
      
      fill(255,255,255);
      rect(0,100,width,50);
      fill(0,0,0);
      text("TweetSet Live", 0, 100, 300, 200);
    
  }
  
  
  //Turns on the live tweets version
  if(tweetSetLive == true){
    
      liveStream();
      
  }
  
  
  
  //Turns on the demo version
  if(tweetSetDemo == true) {
      
    myInterface.paint();
     
    image(world,0,0);
      
    if(tweetsOnOffSwitch == 1) {
      
      currentTweet = currentTweet +1;
      println(currentTweet);
      //when currentTweet is 100, we want to go onto the next page
      if(currentTweet==100){
        
        nextPage=true;
        currentTweet=0;
        
      }
      //Need to specify a number so the for loop only calls once
      if(currentTweet == 10){
        //Loop through the cities array and get each object
          for(int j = 0; j < cities.size(); j++){ 
          
              City myCity = cities.get(j);
          
          //The first time we loop through, it will skip this
          //The next time, nextPage will be true, so call the next set of tweets
          //We want to call this for each city          
                  if(nextPage == true) {
                    
                        myCity.makeCity();
                        myCity.getNewTweets();
                        delay(500);
                        println("calling this");
                        
                  }
         
                  for(int k = 0; k < myCity.tweets.size(); k++) {
                         
                        Status status = myCity.tweets.get(k);
                        User user = status.getUser();
          
                        println(myCity.cityName + " " + myCity.tweets.size());
                        /*
                        GeoLocation tweetLoc = status.getGeoLocation();
                        double longitude = tweetLoc.getLongitude();
                        println(longitude);
                        */
                      
                        //Running this piece of code returns when the tweets were created. 
                        String storeDate = "" + status.getCreatedAt();           
                        //The id is in the data type LONG and needs to be converted to a string
                        long idLong = status.getId();
                        String longString = "" + idLong;
                      
                                    
                         //This piece is nearly obsolete, its for displaying a tweet on screen
                   
                         
                        fill(200);
                        text(status.getText(), 100, 100, 300, 200);
                        text(user.getName(), 200, 300, 300, 200);
                        text(longString,300,300,300,200);
                        println(status.getCreatedAt());
                   
                        //For saving to XML
                        //Load up with the data we want from the status object
                        //ID, Author, Date and the CityObjects name.
                        
                        XML newChild = xmlFile.addChild("tweet");  
                        newChild.setContent(status.getText());
                        newChild.setString("tweet-id", longString);
                        newChild.setString("tweet-name", user.getName());
                        newChild.setString("tweet-date", storeDate);
                        newChild.setString("city-name",myCity.cityName);
    
                  }
            }  
        }
    }

    //For the drag
    dublin.move();
    toronto.move();
  }
}

void mouseClicked() {
  deleteTweets(); // Call the delete function from the Handler
  saveTweets();// Call the saveTweets function from the Handler
  pauseTweets();// Call the pauseTweets function from the Handler
  
  //Activate the Demo version.
  if(mouseX >= 0 && mouseX <= width && mouseY >= 00 && mouseY <= 50){
      if(tweetSetDemo == false) {
          tweetSetDemo = true;
          println("This works!!");
      }
  }
  
  //Activate the Live version
  if(mouseX >= 0 && mouseX <= width && mouseY >= 100 && mouseY <= 150){
      if(tweetSetLive == false) {
          tweetSetLive = true;
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
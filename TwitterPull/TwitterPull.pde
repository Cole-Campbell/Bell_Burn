import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;

PImage world;
PImage dublinMap;
PImage torontoMap;

//String is not needed anymore, can leave it here for now as a note
//Incase we want to put it back in, pass it through the Query object.
String search = "";

//For loading up and saving the XML files.
String xml = "storeTweets.xml";
String saveXml = "data/storeTweets.xml";

//This keeps track of what tweet we are on and when ready changes nextPage to true
int currentTweet;
boolean nextPage = false;
//Keeps track of the page number. Should probably but in the city class.
int pageNum = 1;

//Array list to store the cities.
List<City> cities;

//Array List to store Particles
ArrayList<Particle> myParticle;  
ArrayList<Display> mainDisplay;

//For the pause button
int tweetsOnOffSwitch = 1;

// To store the XML file location.
XML xmlFile;

//Create a new Interface
Interface myInterface;

//Cities
City dublin;
City toronto;
City nyc;
City tokyo;

//Controls for the menu
boolean tweetSetDemo = false;
boolean tweetSetLive = false;
boolean tweetSetPlay = false;

//Every 4.7 pixels is equal to one degree latitude and ever 4 pixels is equal to one degree longitude
//Dependant on the screen size
float latPix = 4.7;
float longPix = 4;

//This is for the timer. Counts down from the number specified here.
int timerCount = 6;
Calendar incrementMe;

//For comparing the incremented time to the tweetTime
int curHH = 0;
int curMM = 0;

void setup() {

  //fullScreen();
  size(1000, 500);
  background(0);

  //Initialize the arraylists.
  myParticle = new ArrayList <Particle>();
  mainDisplay = new ArrayList <Display>();
  cities = new ArrayList<City>();
  
  //Make cities and then add them to the arrayList.
                    //cityName, Latitude, Longitude,      xPos,         yPos,      radius
  //dublin = new City("Dublin", 53.344104, -6.2674937, 53.344104*longPix , -6.26*latPix, 100);
  dublin = new City("Dublin", 53.344104, -6.2674937, 1000 , 300, 10);
  cities.add(dublin);
  
  //toronto = new City("Toronto", 43.6525, -79.381667, -79.381667*longPix, 43.6525*-latPix, 100);
  toronto = new City("Toronto", 43.6525, -79.381667, width/2 - width/4, height/2, 1);
  cities.add(toronto);
  
  //nyc = new City("nyc", 40.70979201243498, -73.992919921875, 558, 518, 1);
  //cities.add(nyc);
  
  //tokyo = new City("tokyo", 35.6833, 139.6833, 0, 0, 1);
  //cities.add(tokyo);

  //Add in the maps
  xmlFile = loadXML(xml);
  xmlLive = loadXML(liveXml);
  world = loadImage("world.png");
  //dublinMap = loadImage("dub.jpg");
  //torontoMap = loadImage("tor.jpg");
  world.resize(800,600);

                             //width,height,xPos,yPos
  myInterface = new Interface(width, 50, 0, height - 50); //Initiate the interface

  //This is for the twitter codes.
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey(con);
  cb.setOAuthConsumerSecret(conS);
  cb.setOAuthAccessToken(access);
  cb.setOAuthAccessTokenSecret(accessS);

  //Initialize Twitter4J
  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();
  
  //Need to call this once. If not called, then the tweetList array is empty and throws an error.
  dublin.getNewTweets();
  toronto.getNewTweets();
  //nyc.getNewTweets();
  //tokyo.getNewTweets();

  currentTweet = 0;
  
  //Set up a new date.time. Go back by X hours.
  incrementMe = Calendar.getInstance();
  println(incrementMe.getTime());
  incrementMe.add(Calendar.HOUR, -4);
}

void draw() {
  fill(255);
  
/*------------LIVE VERSION-------------*/
  if (tweetSetLive == true) {
    liveStream();
  }

/*------------DEMO VERSION-------------*/
  //Turns on the demo version
  if (tweetSetDemo == true) {
    demoVersion();
  }

/*------------DISPLAY VERSION-------------*/
  if (tweetSetPlay == true) {
    displayTweets();
    timer();
    rect(720,570,10,10);
  }
  for(int x = 0; x<=width; x++){
    Display aDisplay = mainDisplay.get(x);
    aDisplay.paint();
  }
  
  //Keeps check on how many particles there are, removes them when its time.
  for(int q = 0; q<=myParticle.size()-1; q++){    
      //println(q);
      Particle aParticle = myParticle.get(q);
      aParticle.paint();
      
      if (aParticle.timeUp() == true) {
        myParticle.remove(aParticle);              
      }              
  }
/*------------MAIN MENU-----------------*/
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
  //If we are on not on the main menu then make this button
  else{
    fill(30,90,50);    
    rect(width - 100, height - 50, 100, 50);
    fill(0,0,0);
    text("Back", width - 100, height - 40, 100, 50);
  }
}






    
  
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
//import guru.ttslib.*;

Twitter twitter;

float originX = width/2;
//Backgrounds for the canvas
PImage world;

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

ArrayList <Display> display;

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
float latPix = 4.677777778;
float longPix = 4;

//This is for the timer. Counts down from the number specified here.
int timerCount = 6;
Calendar incrementMe;

//For comparing the incremented time to the tweetTime
int curHH = 0;
int curMM = 0;

//TTS tts;

void setup() {
  //fullScreen();
  size(1440, 700);

  //Initialize the arraylists.
  myParticle = new ArrayList <Particle>();
  cities = new ArrayList<City>();
  display = new ArrayList <Display>();
  shootingParticles = new ArrayList<Particle>();
  //tts = new TTS();
  //Make cities and then add them to the arrayList.
  //                cityName, Latitude, Longitude,  xPos,         yPos,      radius     r  g   b       
  dublin = new City("Dublin", 53.344104, -6.2675, -6.26*longPix, 53.344104*-latPix, 2, 155,20,155);
  cities.add(dublin);

  toronto = new City("Toronto", 43.6525, -79.381667, -79.381667*longPix, 43.6525*-latPix, 2, 40,200,30);
  cities.add(toronto);

  nyc = new City("nyc", 40.70979201243498, -73.992919921875, -73.992919921875*longPix, 40.70979201243498*-latPix, 2, 60,60,190);
  cities.add(nyc);

  tokyo = new City("tokyo", 35.6833, 139.6833, 139.6833*longPix, 35.6833*-latPix, 2, 70,170,80);
  cities.add(tokyo);

  //Add in the maps
  xmlFile = loadXML(xml);
  xmlLive = loadXML(liveXml);
  world = loadImage("world.png");
  world.resize(width, height);

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
  background(0);
  /*------------LIVE VERSION-------------*/
  if (tweetSetLive == true) {
    delay(30);
    liveStream();
    for (int q = 0; q<= shootingParticles.size()-1; q++) {    
    //println(q);
    Particle aParticle = shootingParticles.get(q);
    if(aParticle.xPos > originX){
      float getSpeed = aParticle.xPos + originX;
      getSpeed = getSpeed/100 + 2;
      aParticle.xPos -= getSpeed;
    }
    else{
      float getSpeed = (aParticle.xPos * -1) - (originX * -1);
      getSpeed = getSpeed/100 + 1;
      //getSpeed = getSpeed * -1;
      aParticle.xPos += getSpeed;
    }
    if(aParticle.yPos < 0){
      aParticle.yPos-=7;
    }
    }
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
  else {
    fill(30, 90, 50);    
    rect(width - 100, height - 50, 100, 50);
    fill(0, 0, 0);
    text("Back", width - 100, height - 40, 100, 50);
  }
}
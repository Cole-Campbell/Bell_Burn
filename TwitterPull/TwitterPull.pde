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

//This keeps track of what tweet we are on and when ready changes nextPage to true
int currentTweet;
boolean nextPage = false;


//Arraylist to store the status (the tweet);
List<City> cities;
//List<Status> tweets;

//Array List for Particles
ArrayList<Particle> myParticle;

//Going to put in a switch to turn on and off the get tweets function
int tweetsOnOffSwitch = 1;

// To store the XML file location.
XML xmlFile;

Interface myInterface;

int pageNum = 1;

City dublin;
City toronto;
City nyc;
City tokyo;

boolean tweetSetDemo = false;
boolean tweetSetLive = false;
boolean tweetSetPlay = true;

//Every 5.55 pixels is equal to one degree latitude and ever 4 pixels is equal to one degree longitude
float latPix = 5.55;
float longPix = 4;

//This is for the timer
int timerCount = 6;
Calendar incrementMe;

//For comparing the incremented time to the tweetTime
int curHH = 0;
int curMM = 0;

void setup() {

  //fullScreen();
  size(1440, 769);

  myParticle = new ArrayList <Particle>();
  cities = new ArrayList<City>();
  
  dublin = new City("Dublin", 53.344104, -6.2674937, -6.2674937*4 , 53.344104*-5.5, 10);
  cities.add(dublin);
  toronto = new City("Toronto", 43.6525, -79.381667, -79.381667*4, 43.6525*-latPix, 1);
  cities.add(toronto);
  //println(cities.size() + toronto.longitude + toronto.latitude);
  nyc = new City("nyc", 40.70979201243498, -73.992919921875, 558, 518, 1);
  cities.add(nyc);
  
  tokyo = new City("tokyo", 35.6833, 139.6833, 0, 0, 1);
  cities.add(tokyo);


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
  nyc.getNewTweets();
  tokyo.getNewTweets();

  currentTweet = 0;
  
  incrementMe = Calendar.getInstance();
  println(incrementMe.getTime());
  incrementMe.add(Calendar.HOUR, -4);
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
  }
    for(int q = 0; q<=myParticle.size()-1; q++){    
        //println(q);
        Particle aParticle = myParticle.get(q);
        aParticle.paint();
        
        if (aParticle.timeUp() == true) {
          myParticle.remove(aParticle);              
        }              
    }

}
    
  
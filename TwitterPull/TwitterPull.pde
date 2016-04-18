import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
import guru.ttslib.*;

Twitter twitter;

float originX = width/2;
//Backgrounds for the canvas
PImage world;
PImage demoWorld;

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
City saoPaulo;
City seoul;
City mexicoCity;
City mumbai;
City delhi;
City lagos;
City moscow;
City paris;
City beijing;
City chicago;
City london;
City lima;
City bangkok;
City baghdad;
City bangalore;
City philadelphia;
City miami;
City madrid;
City milan;
City dallas;
City washington;
City berlin;
City houston;
City montreal;
City phoenix;
City capetown;
City calgary;
City melbourne;
City rome;
City sandiego;
City sanfrancisco;
City glasgow;
City vancouver;
City stjohns;
City copenhagen;

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
  dublin = new City("Dublin", 53.344104, -6.2675, -6.26*longPix, 53.344104*-latPix, 2, 155, 20, 155);
  cities.add(dublin);

  toronto = new City("Toronto", 43.653226, -79.383184, -79.383184*longPix, 43.653226*-latPix, 2, 40, 200, 30);
  cities.add(toronto);

  nyc = new City("nyc", 40.712784, -74.005941, -74.005941*longPix, 40.712784*-latPix, 2, 60, 60, 190);
  cities.add(nyc);

  tokyo = new City("Tokyo", 35.689487, 129.691706, 129.691706*longPix, 35.6833*-latPix, 2, 70, 170, 80);
  cities.add(tokyo);
  
  saoPaulo = new City("Sao Paulo", -23.550520, -46.633309, -46.633309*longPix, -23.550520*latPix, 2, 70, 170, 80);
  cities.add(saoPaulo);
  
  seoul = new City("seoul", 37.566535, 126.977969 , 126.977969*longPix, 37.566535*-latPix, 2, 70, 170, 80);
  cities.add(seoul);
  
  mexicoCity = new City("Mexico City", 19.432608, -99.133208 , -99.133208*longPix, 19.432608*-latPix, 2, 70, 170, 80);
  cities.add(mexicoCity);
  
  mumbai = new City("Mumbai", 19.075984, 72.877656 , 72.877656*longPix, 19.075984*-latPix, 2, 70, 170, 80);
  cities.add(mumbai);
  
  delhi = new City("Delhi", 28.613939, 77.209021, 77.209021*longPix, 28.613939*-latPix, 2, 70, 170, 80);
  cities.add(delhi);
  
  lagos = new City("Lagos", 6.524379, 3.379206, 3.379206*longPix, 6.524379*-latPix, 2, 70, 170, 80);
  cities.add(lagos);
  
  moscow = new City("Moscow", 55.755826, 37.6173, 37.6173*longPix, 55.755826*-latPix, 2, 70, 170, 80);
  cities.add(moscow);
  
  paris = new City("Paris", 48.856616, 2.352222, 2.352222*longPix, 48.856616*-latPix, 2, 70, 170, 80);
  cities.add(paris);
  
  beijing = new City("Beijing", 39.904211, 116.407395, 116.407395*longPix, 39.904211*-latPix, 2, 70, 170, 80);
  cities.add(beijing);
  
  chicago = new City("Chicago", 41.878114, -87.629798, -87.629798*longPix, 41.878114*-latPix, 2, 70, 170, 80);
  cities.add(chicago);
  
  london = new City("London", 51.507351, -0.127758, -0.127758*longPix, 51.507351*-latPix, 2, 70, 170, 80);
  cities.add(london);
  
  lima = new City("Lima", -12.046374, -77.042793, -77.042793*longPix, -12.046374*latPix, 2, 70, 170, 80);
  cities.add(lima);
  
  bangkok = new City("Bangkok", 13.756331, 100.501765, 100.501765*longPix, 13.756331*-latPix, 2, 70, 170, 80);
  cities.add(bangkok);
  
  baghdad = new City("Baghdad", 33.312806, 44.361488, 44.361488*longPix, 33.312806*-latPix, 2, 70, 170, 80);
  cities.add(baghdad);
  
  bangalore = new City("Bangalore", 12.971599, 77.594563, 77.594563*longPix, 12.971599*-latPix, 2, 70, 170, 80);
  cities.add(bangalore);
  
  philadelphia = new City("Philadelphia", 39.952584, -75.165222, -75.165222*longPix, 39.952584*-latPix, 2, 70, 170, 80);
  cities.add(philadelphia);
  
  miami = new City("Miami", 25.761680, -80.191790, -80.191790*longPix, 25.761680*-latPix, 2, 70, 170, 80);
  cities.add(miami);
  
  madrid = new City("Madrid", 40.416775, -3.703790, -3.703790*longPix, 40.416775*-latPix, 2, 70, 170, 80);
  cities.add(madrid);
  
  milan = new City("Milan", 45.465422, 9.185924, 9.185924*longPix, 45.465422*-latPix, 2, 70, 170, 80);
  cities.add(milan);
  
  dallas = new City("Dallas", 32.776664, -96.796988, -96.796988*longPix, 32.776664*-latPix, 2, 70, 170, 80);
  cities.add(dallas);
  
  washington = new City("Washington", 38.907192, -77.036871, -77.036871*longPix, 38.907192*-latPix, 2, 70, 170, 80);
  cities.add(washington);
  
  berlin = new City("Berlin", 52.520007, 13.404954, 13.404954*longPix, 52.520007*-latPix, 2, 70, 170, 80);
  cities.add(berlin);
  
  houston = new City("Houston", 29.760427, -95.369803, -95.369803*longPix, 29.760427*-latPix, 2, 70, 170, 80);
  cities.add(houston);
  
  montreal = new City("Montreal", 45.501689, -73.567256, -73.567256*longPix, 45.501689*-latPix, 2, 70, 170, 80);
  cities.add(montreal);
  
  phoenix = new City("Phoenix", 33.448377, -112.074037, -112.074037*longPix, 33.448377*-latPix, 2, 70, 170, 80);
  cities.add(phoenix);
  
  capetown = new City("Cape Town", -33.924869, 18.424055, 18.424055*longPix, -33.924869*latPix, 2, 70, 170, 80);
  cities.add(capetown);
  
  calgary = new City("Calgary", 51.048615, -114.070846, -114.070846*longPix, 51.048615*-latPix, 2, 70, 170, 80);
  cities.add(calgary);
  
  melbourne = new City("Melbourne", -37.814107, 144.963280, 144.963280*longPix, -37.814107*latPix, 2, 70, 170, 80);
  cities.add(melbourne);
  
  rome = new City("Rome", 41.902783, 12.496366, 12.496366*longPix, 41.902783*-latPix, 2, 70, 170, 80);
  cities.add(rome);
  
  sandiego = new City("San Diego", 32.715738, -117.161084, -117.161084*longPix, 32.715738*-latPix, 2, 70, 170, 80);
  cities.add(sandiego);
  
  sanfrancisco = new City("San Francisdo", 37.774929, -122.419416, -122.419416*longPix, 37.774929*-latPix, 2, 70, 170, 80);
  cities.add(sanfrancisco);
  
  glasgow = new City("Glasgow", 55.864237, -4.251806, -4.251806*longPix, 55.864237*-latPix, 2, 70, 170, 80);
  cities.add(glasgow);
  
  vancouver = new City("Vancouver", 45.638728, -122.661486, -122.661486*longPix, 45.638728*-latPix, 2, 70, 170, 80);
  cities.add(vancouver);
  
  stjohns = new City("St. Johns", 47.560541, -52.712831, -52.712831*longPix, 47.560541*-latPix, 2, 70, 170, 80);
  cities.add(stjohns);
  
  copenhagen = new City("Copenhagen", 55.676097, 12.568337, 12.568337*longPix, 55.676097*-latPix, 2, 70, 170, 80);
  cities.add(copenhagen);

  frameRate(30%1);

  //Add in the maps
  xmlFile = loadXML(xml);
  xmlLive = loadXML(liveXml);
  world = loadImage("world.png");
  demoWorld = loadImage("demoWorld.png");
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
      if (aParticle.xPos > originX) {
        float getSpeed = aParticle.xPos + originX;
        getSpeed = getSpeed/100 + 2;
        aParticle.xPos -= getSpeed;
      } else {
        float getSpeed = (aParticle.xPos * -1) - (originX * -1);
        getSpeed = getSpeed/100 + 1;
        //getSpeed = getSpeed * -1;
        aParticle.xPos += getSpeed;
      }
      if (aParticle.yPos < 0) {
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
    for (int d = 0; d<= display.size()-1; d++) {    
      //println(q);
      Display squareDisplay = display.get(d);
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
  else {
    fill(30, 90, 50);    
    rect(width - 100, height - 50, 100, 50);
    fill(0, 0, 0);
    text("Back", width - 100, height - 40, 100, 50);
  }
}
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
import codeanticode.syphon.*;
import guru.ttslib.*;

Twitter twitter;

//Point where tweets will ping towards.
float originX = width/2;

//Backgrounds for the canvas
PImage world;
PImage demoWorld;

//Canvas tag which later gets exported out to the Syphon server for use in MadMapper/VPT.
PGraphics canvas;
SyphonServer server;

//For loading up and saving the XML files.
String xml = "storeTweets.xml";
String saveXml = "data/storeTweets.xml";

//This keeps track of what tweet we are on and when ready changes nextPage to true
int currentTweet;
boolean nextPage = false;

//Keeps track of the page number.
int pageNum = 1;

//Setting up ArrayLists
List<City> cities;
ArrayList<Particle> myParticle; 
ArrayList <Display> display;

//For the pause button
int tweetsOnOffSwitch = 1;

// To store the XML file location.
XML xmlFile;

//Create a new Interface
Interface myInterface;

//Controls for the menu
boolean tweetSetDemo = false;
boolean tweetSetLive = false;
boolean tweetSetPlay = false;

//Every 4.7 pixels is equal to one degree latitude and ever 4 pixels is equal to one degree longitude
//Dependant on the screen size
float latPix = 4.6777;
float longPix = 4;

//This is for the timer. Counts down from the number specified here.
int timerCount = 6;
Calendar incrementMe;
boolean timeIncreased = false;
//For comparing the incremented time to the tweetTime
int curHH = 0;
int curMM = 0;

TTS tts;
int colour = 255;

String liveXml = "data/liveTweets.xml";
XML xmlLive;
ArrayList<Particle> shootingParticles;
boolean startThread = false;
LiveRun p;
void setup() {
  //fullScreen();
  //size(1440, 700);
  size(1440,785, P3D);
  canvas = createGraphics(1440,785,P3D);
  //Initialize the arraylists.
  myParticle = new ArrayList <Particle>();
  cities = new ArrayList<City>();
  display = new ArrayList <Display>();
  shootingParticles = new ArrayList<Particle>();
  //Initialize the cities
  initCities();
  //Start up the Text-To-Speech
  tts = new TTS();
  frameRate(25);
  
  p = new LiveRun();
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
  //cb.setOAuthConsumerKey(con);
  //cb.setOAuthConsumerSecret(conS);
  //cb.setOAuthAccessToken(access);
  //cb.setOAuthAccessTokenSecret(accessS);
  
  cb.setOAuthConsumerKey(liveCon);
  cb.setOAuthConsumerSecret(liveConS);
  cb.setOAuthAccessToken(liveAccess);
  cb.setOAuthAccessTokenSecret(liveAccessS);

  //Initialize Twitter4J
  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();

  //Need to call this once. If not called, then the tweetList array is empty and throws an error.
  
  currentTweet = 0;

  //Set up a new date.time. Go back by X hours.
  incrementMe = Calendar.getInstance();
  println(incrementMe.getTime());
  incrementMe.add(Calendar.MINUTE, -59);
  println(incrementMe.getTime());
  //Creates the syphon server in which we later broadcast the Canvas to the Syphon Client for MadMapper
  server = new SyphonServer(this, "Processing Syphon");
  
  //for (int y = 0; y<=height/10; y++) {
    //  for (int x = 0; x<=width; x++) {
        //xPosition, yPosition, start Latitude, end latitude, start longitude, end longitude, colour
      //  display.add(new Display(10*x, 10*y, -180+(longPix*x), -180+(longPix*(x+1)), 76.8-(latPix*y), 76.8-(latPix*(y+1)), colour));
     // }
    //}
}

void draw() {
  canvas.beginDraw();
  canvas.fill(255);
  canvas.background(0);
  /*------------LIVE VERSION-------------*/
  if (tweetSetLive == true) {
    canvas.image(world, 0, 0);
    myInterface.paint();
    for (int q = 0; q<= shootingParticles.size()-1; q++) {    
      Particle aParticle = shootingParticles.get(q);
      aParticle.paint();
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
    new Thread(p).start();
    if(frameCount % 25 == 1){
       startThread = true;;
    }

  }

  /*------------DEMO VERSION-------------*/
  //Turns on the demo version
  if (tweetSetDemo == true) {
    myInterface.paint();
    demoVersion();
  }

  /*------------DISPLAY VERSION-------------*/
  timer();
  if (tweetSetPlay == true) {
    canvas.image(world,0,0);
    for (int w = 0; w < cities.size (); w++) {
      City myLittleCity = cities.get(w);
      myLittleCity.makeCity();
    }
    displayTweets();
    /*for (int d = 0; d<= display.size()-1; d++) {    
      //println(q);
      Display squareDisplay = display.get(d);
      squareDisplay.paint();
    }*/
    
  }

  /*------------MAIN MENU-----------------*/
  if (tweetSetDemo == false && tweetSetLive == false && tweetSetPlay == false) {    
    canvas.fill(255, 255, 255);
    canvas.rect(0, 0, width, 50);
    canvas.fill(0, 0, 0);
    canvas.text("TweetSet Demo", 0, 0, 300, 200);

    canvas.fill(255, 255, 255);
    canvas.rect(0, 100, width, 50);
    canvas.fill(0, 0, 0);
    canvas.text("TweetSet Live", 0, 100, 300, 200);

    canvas.fill(255, 255, 255);
    canvas.rect(0, 200, width, 50);
    canvas.fill(0, 0, 0);
    canvas.text("TweetSet Play", 0, 200, 300, 200);
  }
  //If we are on not on the main menu then make this button
  else {
    canvas.fill(30, 90, 50);    
    canvas.rect(width - 100, height - 50, 100, 50);
    canvas.fill(0, 0, 0);
    canvas.text("Back", width - 100, height - 40, 100, 50);
  }
  canvas.endDraw();
  image(canvas,0,0);
  server.sendImage(canvas);
}

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

QueryResult result;
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

boolean tweetSetDemo = false;
boolean tweetSetLive = false;
boolean tweetSetPlay = false;

//This is for the timer
int timerCount = 6;
Calendar incrementMe;

void setup() {

  fullScreen();
  //size(800, 600);

  myParticle = new ArrayList <Particle>();
  cities = new ArrayList<City>();
  dublin = new City("Dublin", 53.344104, -6.2674937, 200, 100, 50);
  toronto = new City("Toronto", 43.6525, -79.381667, 400, 200, 50);
  cities.add(toronto);
  cities.add(dublin);


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
  
  incrementMe = Calendar.getInstance();
  println(incrementMe.getTime());
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
    demoVersion();
  }
  //println(xmlCity);
  //TweetSet Play
  if (tweetSetPlay == true) {
    image(world, 0, 0);
    for (int a = 0; a < cities.size(); a++) { 
      City myCity = cities.get(a);
     // myCity.makeCity();
     
    }
    dublin.move();
    toronto.move();
    world.resize(width, height);

    fill (0,255,0);
    //Load up all the tweets from the XML file.
    XML[] tweetList = xmlFile.getChildren("tweet");
    //We only need to do this once a second, 
    if (frameCount%30==1) {
      //We need to extract all the tweets we have saved
      for (int t=0; t<tweetList.length; t++) {
        //Store the tweets attributes
        String tweetDate = tweetList[t].getString("tweet-date");
        String tweetCity = tweetList[t].getString("city-name");
        Double tweetLat = tweetList[t].getDouble("latitude");
        Double tweetLong = tweetList[t].getDouble("longitude");
        String tweetDateString = tweetDate.substring(11, 19) + " ";
               
        //We then need to compare them.
        //So go through each city
        for (int j = 0; j < cities.size(); j++) { 
        City whichCity = cities.get(j);
          //check which city we are currently on
          if(tweetCity.equals(whichCity.cityName)){
            //THESE NEED TO BE THE WRONG WAY AROUND FOR SOME REASON
            println("City latitude is: " + whichCity.longitude);
            println("City Longitude is: " + whichCity.latitude);
            println("City Name is: " + whichCity.cityName);
            println(" ");
            println("Tweet City is: " + tweetCity);
            println("Tweet Latitude is: " + tweetLat);
            println("Tweet Longitude is: " + tweetLong);
            println(" ");
            
            double differenceLat = whichCity.longitude - tweetLat;           
            double differenceLong = whichCity.latitude - tweetLong;
            
            //float a = (float)whichCity.longitude;
            float b = (float)differenceLong;
            
            //float c = (float)whichCity.latitude;
            float d = (float)differenceLat;
            
            //a = a * 100;
            b = b * 100;
            d = d * 100;
            println("Longitude difference is equal to " + Math.floor(b));
            println("Latitude difference is equal to " + Math.floor(d));
            println("The difference between latitudes is: " + differenceLat);
            println("The difference between longitudes is: " + differenceLong);
            
            println(" ");
            println("////// ");
            println(" ");
            
            
            
            //B = difference of longitude * 1000
            println("The difference between the longitude " + b+whichCity.xPos);
            fill(255,255,255);
            myParticle.add(new Particle(b+whichCity.xPos, d+whichCity.yPos));
            
            rect(b+whichCity.xPos, d+whichCity.yPos,10,10);
            
            //rect(whichCity.xPos + differenceLat, whichCity.yPos + differenceLong, 5, 5);
            //so now that we know the city
            //we can compare the tweets lat and longitude
          }  
        }
      }
    }
    for(int q = 0; q<=myParticle.size()-1; q++){
              Particle aParticle = myParticle.get(q);
              aParticle.paint();
              if (aParticle.timeUp() == true) {
                myParticle.remove(aParticle);              
              }
            }
  }
    
       
    
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
  timer();
}
    
  
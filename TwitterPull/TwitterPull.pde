import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;

String search = "Clonmel";
int currentTweet;
List<Status> tweets;

//Currently looks like same tweets are popping up.
//I dont think refresh tweets is being called.
//Going to make a mouse click function to call the refresh tweets
//^^ UPDATE TO THIS
//I added in a time stamp and it goes from the newest to the oldest
//And then loops back around
boolean clickToRefresh = false;

//Going to put in a control to turn on and off the get tweets function
//Spacebar turns it on/off
int tweetsOnOffSwitch = 1;
// To store the XML file location.
XML xmlFile;

/*
The “Consumer Key”: LuxDk9NaQOvqqQkn9LOXmwBY1
The “Consumer Secret”: 0IANaFy2X3qNx6rKc3drLit6kG7ETPOGBZD1GYL5YSopZiw5j2
The “Access Token”: 537618780-TnQbYM3IS88usjTURUFyX2QJTL2kwBZemAqOCQKu
The “Access Token Secret”: CWwSNlbOajW0cxG211yfCOaLS5SYurJGWeoVEUNxiBUYL
 */

void setup() {
  size(800, 600);
  
  xmlFile = loadXML("storeTweets.xml");
  
  ConfigurationBuilder cb = new ConfigurationBuilder();

  cb.setOAuthConsumerKey("LuxDk9NaQOvqqQkn9LOXmwBY1");
  cb.setOAuthConsumerSecret("0IANaFy2X3qNx6rKc3drLit6kG7ETPOGBZD1GYL5YSopZiw5j2");
  cb.setOAuthAccessToken("537618780-TnQbYM3IS88usjTURUFyX2QJTL2kwBZemAqOCQKu");
  cb.setOAuthAccessTokenSecret("CWwSNlbOajW0cxG211yfCOaLS5SYurJGWeoVEUNxiBUYL");

  TwitterFactory tf = new TwitterFactory(cb.build());

  twitter = tf.getInstance();

  getNewTweets();

  currentTweet = 0;
}

void draw() {
  fill(0, 40);
  rect(0, 0, width, height);

  currentTweet = currentTweet +1;
  background(0);


  if (currentTweet >= tweets.size()) {
    currentTweet = 0;
  }
  
  /*http://twitter4j.org/javadoc/twitter4j/Status.html*/
  Status status = tweets.get(currentTweet);
  //I found this part a little confusing
  //First we get the current tweet
  //We store it in a status object,
  //Then we can make a User object, then put the status.user property(its in JSON) into that object
  //then we can get different attributes associated with it.
  User user = status.getUser();
  
  //Running this piece of code returns when the tweets were created. 
  //Will store this in XML as well. 
  println(status.getCreatedAt());
  String storeDate = "" + status.getCreatedAt();

  
  
  //Ok, so tweets come up, but seems like some are repeated.
  //In order to eliminate these from being saved to the XML file and being false data
  //One possible solution is we must get each ones id, then compare it to the rest of the IDs.
  //And only add it to the XML file if the ID is unique. For loop, load XML, check then add or delete.
  
  //The id is in the data type LONG
  //In order to convert to string I had to use concatenation. 
  long idLong = status.getId();
  String longString = "" + idLong;
  fill(200);
  
  //Space switches the number
  //Control to turn it on and off
  if(tweetsOnOffSwitch == 1) {
  text(status.getText(), 100, 100, 300, 200);
  text(user.getName(), 200, 300, 300, 200);
  text(longString,300,300,300,200);
  delay(2000);
  }
  
  //XML[] tweetsInFile = xmlFile.getChildren("tweet");
  //Declaring a new XML object to add to the file  
  //XML oldChild = xmlFile.getChild("tweets");
  //Set its content to == the tweet text
  XML newChild = xmlFile.addChild("tweet");  
  newChild.setContent(status.getText());
  //give the tweet an ID attribute
  newChild.setString("tweet-id", longString);
  //give the tweet a userName attribute
  newChild.setString("tweet-name", user.getName());
  //give the tweet a date attribute
  newChild.setString("tweet-date", storeDate);
  //Have cleaned this up and removed the old method i was using.
  //Not sure if theres other pieces we should add.
  
  //If mouse clicked is true, it will refresh the tweets.
  //Also put the save tweets to XML in here so it will only save on click.
  if(clickToRefresh == true) {
    saveXML(xmlFile, "data/storeTweets.xml");
    getNewTweets();
    clickToRefresh = false;
  }

}

void getNewTweets() {
  try {
    //Try to get tweets here
    Query query = new Query(search);
    QueryResult result = twitter.search(query);
    tweets = result.getTweets();
    println("Tweets refreshed");
  }
  catch (TwitterException te) {
    // Deal with the case where we cant get them here 
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}

//Deleted the refresh tweets method, using mouseCLick to refresh instead
void mouseClicked() {
  if (clickToRefresh == false) {
    clickToRefresh = true;
  }
}

//If you press space, it will stop the tweet stream
void keyPressed() {
    if (keyCode == ' ') {
     tweetsOnOffSwitch = tweetsOnOffSwitch * -1;
     println("switched");
    }    
}

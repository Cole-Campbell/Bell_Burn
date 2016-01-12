import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;

String search = "Dublin";
int currentTweet;
List<Status> tweets;

//Currently looks like same tweets are popping up.
//I dont think refresh tweets is being called.
//Going to make a mouse click function to call the refresh tweets
boolean clickToRefresh = false;

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

  Status status = tweets.get(currentTweet);

  fill(200);
  text(status.getText(), random(width), random(height), 300, 200);
  delay(1000);
  
  //Declaring a new XML object to add to the file  
  XML newChild = xmlFile.addChild("tweet");
  //Set its content to == the tweet text
  newChild.setContent(status.getText());
  
  
  //If mouse clicked is true, it will refresh the tweets.
  //Also put the save tweets to XML in here so it will only save on click.
  if(clickToRefresh == true) {
    saveXML(xmlFile, "storeTweets.xml");
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
/* Im not sure this is needed? 
   To refresh tweets you must click, it calls this function, which then calls getNewTweets
   Easier just to remove this step?
   
void refreshTweets() {
  while (true) {
    getNewTweets();

    println("Updated Tweets");

    delay(30000);
  }
}*/

void mouseClicked() {
  if (clickToRefresh == false) {
    clickToRefresh = true;
  }
}


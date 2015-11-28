import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;

String search = "Werk";
int currentTweet;
List<Status> tweets;

/*
The “Consumer Key”: LuxDk9NaQOvqqQkn9LOXmwBY1
The “Consumer Secret”: 0IANaFy2X3qNx6rKc3drLit6kG7ETPOGBZD1GYL5YSopZiw5j2
The “Access Token”: 537618780-TnQbYM3IS88usjTURUFyX2QJTL2kwBZemAqOCQKu
The “Access Token Secret”: CWwSNlbOajW0cxG211yfCOaLS5SYurJGWeoVEUNxiBUYL
 */

void setup() {
  size(800, 600);

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

  delay(2500);
}

void getNewTweets() {
  try {
    //Try to get tweets here
    Query query = new Query(search);

    QueryResult result = twitter.search(query);
    tweets = result.getTweets();
  }
  catch (TwitterException te) {
    // Deal with the case where we cant get them here 
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}

void refreshTweets() {
  while (true) {
    getNewTweets();

    println("Updated Tweets");

    delay(30000);
  }
}
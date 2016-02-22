/*
REF: https://github.com/yusuke/twitter4j/blob/master/twitter4j-examples/src/main/java/twitter4j/examples/stream/PrintSampleStream.java

Had to remove the classes and make it a void for it to work properly

If you remove one of the @Override then you will get an error 
saying that the function MUST call that function.
*/

void liveStream() {
  TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
  StatusListener listener = new StatusListener() {
            @Override
            public void onStatus(Status status) {
                System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText() + status.getCreatedAt());
            }

            @Override
            public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
                System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
            }

            @Override
            public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
                System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
            }

            @Override
            public void onScrubGeo(long userId, long upToStatusId) {
                System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
            }

            @Override
            public void onStallWarning(StallWarning warning) {
                System.out.println("Got stall warning:" + warning);
            }
            @Override
            public void onException(Exception ex) {
                ex.printStackTrace();
            }
        };
        //http://twitter4j.org/javadoc/twitter4j/TwitterStream.html 
                
        twitterStream.addListener(listener);
        
        //I reckon here we can use the filter() function here to only get certain tweets,
        //Same as how the query works maybe
        twitterStream.sample();
        delay(20000);
}
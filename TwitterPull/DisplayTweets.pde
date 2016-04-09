void displayTweets() {
  image(world,0,0);
  world.resize(1440, 774);
  //image(dublinMap,width/2,0);
  //dublinMap.resize(width/2,height - height/5);
  
  //image(torontoMap,0,0);
  //torontoMap.resize(width/2,height - height/5);

  for (int a = 0; a < cities.size(); a++) { 
    City myCity = cities.get(a);
    //myCity.makeCity();  
  }
  
  fill (255);
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
              
      //Grab the hour and minutes, convert them to integers
      String tweetStrHH = tweetDate.substring(11,13);
      String tweetStrMM = tweetDate.substring(14,16);
      int tweetHH = Integer.parseInt(tweetStrHH);
      int tweetMM = Integer.parseInt(tweetStrMM);
      
      //We then need to compare them.
      //So go through each city
      for (int j = 0; j < cities.size(); j++) { 
      City whichCity = cities.get(j);
        //check which city we are currently on
        if(tweetCity.equals(whichCity.cityName)){
          if(tweetHH - curHH == 0){
            if(curMM - tweetMM <= 15){
              //THESE NEED TO BE THE WRONG WAY AROUND FOR SOME REASON
              /*
              println("City latitude is: " + whichCity.longitude);
              println("City Longitude is: " + whichCity.latitude);
              println("City Name is: " + whichCity.cityName);
              println(" ");
              println("Tweet City is: " + tweetCity);
              println("Tweet Latitude is: " + tweetLat);
              println("Tweet Longitude is: " + tweetLong);
              println(" ");
              */
              double differenceLat = whichCity.longitude - tweetLat;           
              double differenceLong = whichCity.latitude - tweetLong;
              
              //float a = (float)whichCity.longitude;
              float b = (float)differenceLong;
              
              //float c = (float)whichCity.latitude;
              float d = (float)differenceLat;
              
              //a = a * 100;
              b = b * 500;
              d = d * 500;
              println("Longitude difference is equal to " + Math.floor(b));
              println("Latitude difference is equal to " + Math.floor(d));
              println("The difference between latitudes is: " + differenceLat);
              println("The difference between longitudes is: " + differenceLong);
              /*
              println(" ");
              println("////// ");
              println(" ");
              println("Here is the mouseX " + mouseX + " and the mouseY " + mouseY);
              
              */
              //B = difference of longitude * 1000
              //println("The difference between the longitude " + b+whichCity.xPos);
              fill(255,255,255);

              //println("The minutes are working");
              //println("The tweets time is = " + tweetDateString);
              //println("This is the latitude of Toronto Tweets " + whichCity.yPos);              
              myParticle.add(new Particle(b+whichCity.xPos, d+whichCity.yPos));
              println("Added a new particle at X: " + (b+whichCity.xPos) + " Y: " + (d+whichCity.yPos) );
              
            }
          }           
        }  
      }
    }
  } 
}

void timer() {
  if(frameCount % 30 == 1) {
     //println("Counting down from ..." + timerCount);
     timerCount--; 
     if(timerCount == 0) {
       incrementMe.add(Calendar.MINUTE, 15);
       String whatTime = incrementMe.getTime() + " ";
       println("Current time = " + whatTime);
       String strHH = whatTime.substring(11,13);
       String strMM = whatTime.substring(14,16);
       
       curHH = Integer.parseInt(strHH);
       curMM = Integer.parseInt(strMM);
       
       println("Current Hour = " + curHH);
       println("Current Min = " + curMM);
       timerCount = 6;  }
  }  
}
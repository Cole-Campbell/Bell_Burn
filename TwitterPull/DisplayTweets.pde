void displayTweets() {
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
            b = b * 100;
            d = d * 100;
            /*println("Longitude difference is equal to " + Math.floor(b));
            println("Latitude difference is equal to " + Math.floor(d));
            println("The difference between latitudes is: " + differenceLat);
            println("The difference between longitudes is: " + differenceLong);
            
            println(" ");
            println("////// ");
            println(" ");
            println("Here is the mouseX " + mouseX + " and the mouseY " + mouseY);
            
            */
            //B = difference of longitude * 1000
            //println("The difference between the longitude " + b+whichCity.xPos);
            fill(255,255,255);
            if(tweetHH - curHH == 0){
              if(curMM - tweetMM <= 30){
                println("The minutes are working");
                println("The tweets time is = " + tweetDateString);
                myParticle.add(new Particle(b+whichCity.xPos, d+whichCity.yPos));
              }
            }

            
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
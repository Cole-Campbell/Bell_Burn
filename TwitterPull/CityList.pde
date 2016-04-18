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

void initCities(){
//Make cities and then add them to the arrayList.
  //                cityName, Latitude, Longitude,  xPos,         yPos,      radius     r  g   b       
  dublin = new City("Dublin", 53.344104, -6.2675, -6.26*longPix, 53.344104*-latPix, 2, 89,111,98);
  cities.add(dublin);

  toronto = new City("Toronto", 43.653226, -79.383184, -79.383184*longPix, 43.653226*-latPix, 2, 147,113,78);
  cities.add(toronto);

  nyc = new City("nyc", 40.712784, -74.005941, -74.005941*longPix, 40.712784*-latPix, 2, 126,161,107);
  cities.add(nyc);

  tokyo = new City("Tokyo", 35.689487, 129.691706, 129.691706*longPix, 35.6833*-latPix, 2, 28,49,69);
  cities.add(tokyo);
  
  saoPaulo = new City("Sao Paulo", -23.550520, -46.633309, -46.633309*longPix, -23.550520*latPix, 2, 195,216,152);
  cities.add(saoPaulo);
  
  seoul = new City("seoul", 37.566535, 126.977969 , 126.977969*longPix, 37.566535*-latPix, 2, 112,22,30);
  cities.add(seoul);
  
  mexicoCity = new City("Mexico City", 19.432608, -99.133208 , -99.133208*longPix, 19.432608*-latPix, 2, 62,105,144);
  cities.add(mexicoCity);
  
  mumbai = new City("Mumbai", 19.075984, 72.877656 , 72.877656*longPix, 19.075984*-latPix, 2, 233,227,180);
  cities.add(mumbai);
  
  delhi = new City("Delhi", 28.613939, 77.209021, 77.209021*longPix, 28.613939*-latPix, 2, 243,155,109);
  cities.add(delhi);
  
  lagos = new City("Lagos", 6.524379, 3.379206, 3.379206*longPix, 6.524379*-latPix, 2, 187,160,202);
  cities.add(lagos);
  
  moscow = new City("Moscow", 55.755826, 37.6173, 37.6173*longPix, 55.755826*-latPix, 2, 174,132,126);
  cities.add(moscow);
  
  paris = new City("Paris", 48.856616, 2.352222, 2.352222*longPix, 48.856616*-latPix, 2, 218,168,155);
  cities.add(paris);
  
  beijing = new City("Beijing", 39.904211, 116.407395, 116.407395*longPix, 39.904211*-latPix, 2, 92,158,173);
  cities.add(beijing);
  
  chicago = new City("Chicago", 41.878114, -87.629798, -87.629798*longPix, 41.878114*-latPix, 2, 227,151,116);
  cities.add(chicago);
  
  london = new City("London", 51.507351, -0.127758, -0.127758*longPix, 51.507351*-latPix, 2, 50,98,115);
  cities.add(london);
  
  lima = new City("Lima", -12.046374, -77.042793, -77.042793*longPix, -12.046374*latPix, 2, 124,144,219);
  cities.add(lima);
  
  bangkok = new City("Bangkok", 13.756331, 100.501765, 100.501765*longPix, 13.756331*-latPix, 2, 209,190,176);
  cities.add(bangkok);
  
  baghdad = new City("Baghdad", 33.312806, 44.361488, 44.361488*longPix, 33.312806*-latPix, 2, 56,63,81);
  cities.add(baghdad);
  
  bangalore = new City("Bangalore", 12.971599, 77.594563, 77.594563*longPix, 12.971599*-latPix, 2, 164,196,168);
  cities.add(bangalore);
  
  philadelphia = new City("Philadelphia", 39.952584, -75.165222, -75.165222*longPix, 39.952584*-latPix, 2, 174,195,170);
  cities.add(philadelphia);
  
  miami = new City("Miami", 25.761680, -80.191790, -80.191790*longPix, 25.761680*-latPix, 2, 106,68,65);
  cities.add(miami);
  
  madrid = new City("Madrid", 40.416775, -3.703790, -3.703790*longPix, 40.416775*-latPix, 2, 88,53,74);
  cities.add(madrid);
  
  milan = new City("Milan", 45.465422, 9.185924, 9.185924*longPix, 45.465422*-latPix, 2, 69,87,7);
  cities.add(milan);
  
  dallas = new City("Dallas", 32.776664, -96.796988, -96.796988*longPix, 32.776664*-latPix, 2, 113,104,0);
  cities.add(dallas);
  
  washington = new City("Washington", 38.907192, -77.036871, -77.036871*longPix, 38.907192*-latPix, 2, 197,214,216);
  cities.add(washington);
  
  berlin = new City("Berlin", 52.520007, 13.404954, 13.404954*longPix, 52.520007*-latPix, 2, 152,108,106);
  cities.add(berlin);
  
  houston = new City("Houston", 29.760427, -95.369803, -95.369803*longPix, 29.760427*-latPix, 2, 120,79,65);
  cities.add(houston);
  
  montreal = new City("Montreal", 45.501689, -73.567256, -73.567256*longPix, 45.501689*-latPix, 2, 143,203,155);
  cities.add(montreal);
  
  phoenix = new City("Phoenix", 33.448377, -112.074037, -112.074037*longPix, 33.448377*-latPix, 2, 91,146,121);
  cities.add(phoenix);
  
  capetown = new City("Cape Town", -33.924869, 18.424055, 18.424055*longPix, -33.924869*latPix, 2, 143,128,115);
  cities.add(capetown);
  
  calgary = new City("Calgary", 51.048615, -114.070846, -114.070846*longPix, 51.048615*-latPix, 2, 118,65,51);
  cities.add(calgary);
  
  melbourne = new City("Melbourne", -37.814107, 144.963280, 144.963280*longPix, -37.814107*latPix, 2, 173,131,80);
  cities.add(melbourne);
  
  rome = new City("Rome", 41.902783, 12.496366, 12.496366*longPix, 41.902783*-latPix, 2, 228,215,243);
  cities.add(rome);
  
  sandiego = new City("San Diego", 32.715738, -117.161084, -117.161084*longPix, 32.715738*-latPix, 2, 224,82,99);
  cities.add(sandiego);
  
  sanfrancisco = new City("San Francisdo", 37.774929, -122.419416, -122.419416*longPix, 37.774929*-latPix, 2, 225,202,177);
  cities.add(sanfrancisco);
  
  glasgow = new City("Glasgow", 55.864237, -4.251806, -4.251806*longPix, 55.864237*-latPix, 2, 237,174,73);
  cities.add(glasgow);
  
  vancouver = new City("Vancouver", 45.638728, -122.661486, -122.661486*longPix, 45.638728*-latPix, 2, 146,173,167);
  cities.add(vancouver);
  
  stjohns = new City("St. Johns", 47.560541, -52.712831, -52.712831*longPix, 47.560541*-latPix, 2, 165,208,168);
  cities.add(stjohns);
  
  copenhagen = new City("Copenhagen", 55.676097, 12.568337, 12.568337*longPix, 55.676097*-latPix, 2, 199,109,126);
  cities.add(copenhagen);
}
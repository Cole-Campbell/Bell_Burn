class Display {
  //Initial variables. Currently only have longS variable. Long/Lat S
  //Are the start of the squares lat/long (Left and Top), while Long/Lat E
  //Are the Squares lat/long (Right and Bottom).
  float longMult = 4;
  float latMult = 4.7;
  float longS = -180;
  float longE = longS+longMult;
  float latS = 75;
  float latE = latS-latMult;
  int test = 145;
  int r = 0;
  int g = 0;
  int b = 0;

  //Declare an array to contain the information of each square, being the x,y,latS&E,
  //longS&E as well as colour, has to be discussed in class.
  float [][] xP = new float[width][height];

  Display() {
    //For loop for both X & Y so that the squares will increment properly
    //And be displayed correctly
    for (int y=0; y<=height-1; y++) {
      for (int x=0; x<=width-1; x++) {
        //longS variable is increated by the lat/long:pixel ratio. Will been to be
        //Calculated to make sure accurate latitude/longitude is added on to each square.
        xP[x][0] = 10*x;
        xP[y][1] = 10*y;

        xP[y][2] = longS;
        xP[y][3] = longS+longMult;
        xP[y][4] = latS;
        xP[y][5] = latS-latMult;

        xP[y][6] = r+x/14;
        xP[y][7] = g+y;
        xP[y][8] = b+x+y/3;
      }
    }
  }

  void paint() {
    //For loops to display the squares from the array. Loops through each of the arrays
    //Getting the proper in for the variable which is then passed to the Array and
    //Displays the square in the proper X/Y location. Lat/Long needs to be added.
    for (int y = 0; y <=height/10; y++) {
      for (int x = 0; x <=width/10; x++) {

        float xPos = xP[x][0];
        float yPos = xP[y][1];

        longS = xP[y][2];
        longE = xP[y][3];
        
        latS = xP[y][4];
        latE = xP[y][5];
        
        fill(xP[x][6], xP[x][7], xP[x][8]);
        //xP[x][6] = xP[x][6];
        rect(xPos, yPos, 10, 10);

        longS = longS+longMult;
        longE+=longMult;
        
        latS = latS+latMult;
        latE-=latMult;

        xP[y][3]=longE;
        xP[y][5]=latE;

        if (longE>=180) {
          //println("First run is " +longE);
          longS = -180;
          longE = -180+longMult;
          xP[y][3] = longE;
          //println("Second run is " +longE);
        } else if (latE< -74) {
          println("First run is " +latE);
          
          println("Second run is " +latE);
        }
      }
    }
  }
}
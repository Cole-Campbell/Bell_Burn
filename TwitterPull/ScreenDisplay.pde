class Display {
  //Initial variables. Currently only have longS variable. Long/Lat S
  //Are the start of the squares lat/long (Left and Top), while Long/Lat E
  //Are the Squares lat/long (Right and Bottom).
  int longS = -180;
  int l;
  //Declare an array to contain the information of each square, being the x,y,latS&E,
  //longS&E as well as colour, has to be discussed in class.
  int [][] xP = new int[width][height];

  Display() {
    //For loop for both X & Y so that the squares will increment properly
    //And be displayed correctly
    for (int y=0; y<=height-1; y+=10) {
      for (int x=0; x<=width-1; x+=10) {
        //longS variable is increated by the lat/long:pixel ratio. Will been to be
        //Calculated to make sure accurate latitude/longitude is added on to each square.
        longS+=1.388888889;
        xP[x][0] = x;
        xP[y][1] = y;
        xP[y][2] = longS;
      }
    }
  }

  void paint() {
    //For loops to display the squares from the array. Loops through each of the arrays
    //Getting the proper in for the variable which is then passed to the Array and
    //Displays the square in the proper X/Y location. Lat/Long needs to be added.
    for (int y = 0; y <=height-1; y+=10) {
      for (int x = 0; x <=width-1; x+=10) {
        l++;
        int xPos = display.xP[x][0];
        int yPos = display.xP[y][1];
        display.xP[x][2] = display.longS+l;
        rect(xPos, yPos, 10, 10);
      }
    }
  }
}
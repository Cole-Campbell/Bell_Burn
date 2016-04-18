public class Display {
  float xPos;
  float yPos;
  float colour;
  //Start lat is the top of a square, closer to the 0 position on the y scale
  double startLat;
  double endLat;
  //Start Long is the right side of the square, closer to the 0 position on the x scale
  double startLong;
  double endLong;
  

  Display(float xPos, float yPos, double startLat, double endLat, double startLong, double endLong, float colour) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.startLat = startLat;
    this.endLat = endLat;
    this.startLong = startLong;
    this.endLong = endLong;
    this.colour = colour;
  }

  void paint(){
    fill(colour);
   rect(xPos, yPos, 10,10);
  }
}
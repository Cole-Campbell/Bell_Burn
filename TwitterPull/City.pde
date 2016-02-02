public class City {
   
  String countryName;
  double longitude;
  double latitude;
  float xPos;
  float yPos;
  float radius;
  
  //Need to pass these arguments when making a city
  //City Name
  //Longitude
  //Latitude
  //circle x
  //circle y
  //circle radius
  public City(String w, double lo, double la, float x, float y, float radius){
    
    this.countryName = w;
    this.longitude = lo;
    this.latitude = la;
    this.xPos = x;
    this.yPos= y;
    this.radius = radius;
  }

  void makeCity() {
    
      fill(255,255,255);
      ellipse(xPos,yPos,radius,radius);
      
  }
  
  
  boolean moving = false;

  void mousePressed() {
      moving = true;
  }
  
  void mouseReleased() {
      moving = false;
  }

  boolean mouseOver(int mx, int my) {
      return ((xPos - mx)*(xPos - mx) + (yPos - my)*(yPos - my)) <= radius*radius;
  }

  void move() {
      if (moving) {
          this.xPos = mouseX;
          this.yPos = mouseY;
      }
  }
}
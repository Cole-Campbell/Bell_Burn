public class City {
   
  String countryName;
  double longitude;
  double latitude;
  
  public City(String w, double lo, double la){
    
    this.countryName = w;
    this.longitude = lo;
    this.latitude = la;
    
  }

  void makeCity() {
    fill(255,255,255);
    ellipse(50,50,50,50);
  }
}
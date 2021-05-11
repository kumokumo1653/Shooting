import processing.net.*;
String serverAddress = "localhost";
Client c;
ArrayList<PVector> points;
void setup() {
  points = new ArrayList<PVector>();
  c = new Client(this, serverAddress, 5555);
}
void draw() {
  background(0);
  fill(255);
  for(int i = 0; i < points.size(); i++){
    PVector p = points.get(i);
    ellipse(p.x, p.y, 5, 5);
  }
}
void mouseClicked() {
  c.write(mouseX + "," + mouseY + '\n');
}
void clientEvent(Client c) {
  String s = c.readStringUntil('\n');
  if (s != null) {
    print("received from server: " + s);
    String[] data = s.trim().split(",");
    int x = parseInt(data[0]);
    int y = parseInt(data[1]);
    points.add(new PVector(x, y));
  }
}
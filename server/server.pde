import processing.net.*;
Server server;
void setup() {
  server = new Server(this, 5555);
  println("start server at address: " + server.ip());
}
void draw() {
  Client c = server.available();
  if (c != null) {
    String s = c.readStringUntil('\n').trim();
    println("received:" + s);
    String[] data = s.split(",");
    int x = parseInt(data[0]);
    int y = parseInt(data[1]);
    server.write(x + "," + y + '\n');
  }
}

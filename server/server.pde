import processing.net.*;
Server server;
void setup() {
  server = new Server(this, 5555);
  println("start server at address: " + server.ip());
}
void draw() {
  Client c = server.available();
  if (c != null) {
    String s = c.readStringUntil('\n');

    server.write(s);
    String[] msg = splitTokens(s);
    println(msg[0]);
  }
}

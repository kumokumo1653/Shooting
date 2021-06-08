import processing.net.*;
import java.util.UUID;
Server server;
void setup() {
  server = new Server(this, 5555);
  println("start server at address: " + server.ip());
  UUID uuid = UUID.randomUUID();
  System.out.println(uuid);
}
void draw() {
  Client c = server.available();
  if (c != null) {
    String s = c.readStringUntil('\n');
    String[] msg = splitTokens(s);
    if(msg.length == 1){
      println(msg[1]);
    }
    server.write(s);
  }
}

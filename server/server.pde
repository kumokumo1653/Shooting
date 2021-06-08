import processing.net.*;
import java.util.Map;
Server server;

HashMap <String,String>players = new HashMap<String,String>();
void setup() {
  server = new Server(this, 5555);
  println("start server at address: " + server.ip());

}
void draw() {
  Client c = server.available();
  if (c != null) {
    String s = c.readStringUntil('\n');
    String[] msg = splitTokens(s);
    if(msg.length == 2){
      //READYの処理
      if(players.containsKey(msg[1])){
        players.replace(msg[1], msg[0]);
      }else{
        players.put(msg[1], msg[0]);
      }
      if(players.size() == 2){
        String sendMsg = "";
        for (String key : players.keySet()) {
          sendMsg += key + " " + players.get(key) + " ";
        }
        sendMsg += "\n";

        print(sendMsg);
        server.write(sendMsg);
      }
    }else{
      server.write(s);
    }
  }
}

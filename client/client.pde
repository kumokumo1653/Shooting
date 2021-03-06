import processing.net.*;
import java.util.UUID;
String serverAddress = "localhost";
Client client;
Character me;
Character enemy;
int t;
PVector cMovement = new PVector(0,0);
PVector eMovement = new PVector(0,0);
int W = 1600;
int H = 900;
boolean cshoot = false;
boolean eshoot = false;
String name = "";
String enemyName = "";
boolean select = false;
boolean waiting = false;
boolean isWin = false;

String selectedChapacter = "";

UUID id;

public enum Mode {
    READY,
    PLAY,
    RESULT
}
Mode mode;
void settings(){
    size(W, H);
}
void setup() {
  frameRate(30);
  client = new Client(this, serverAddress, 5555);
  t = 0;
  mode = Mode.READY;
  id = UUID.randomUUID();
}
void draw() {
    background(#000000);

    if(mode == Mode.READY){
        //a
        fill(#ffcc00);
        rect(400, 600, 150, 50);
        //b
        fill(#ff00cc);
        rect(1050, 600, 150, 50);
        fill(#ffffff);
        textSize(70);
        textAlign(CENTER);
        text("Select Player", 800, 450);
        fill(#000000);
        textSize(30);
        textAlign(LEFT);
        text("PlayerA", 420, 635);
        text("PlayerB", 1070, 635);

        if(selectedChapacter.equals("a")){
            fill(#ffffff);
            textAlign(CENTER);
            text("selectd Player: A", 800, 550);
        }else if(selectedChapacter.equals("b")){
            fill(#ffffff);
            textAlign(CENTER);
            text("selectd Player: B", 800, 550);
        }
        
    }
    if(mode == Mode.PLAY){
        //サーバーに送信
          client.write(name + " " + cMovement.x + " " + cMovement.y + " " +  cshoot + '\n');
        me.move(cMovement);
        enemy.move(eMovement);

        if(cshoot){
            cshoot = false;
            me.shoot(enemy.pos);
        }
        if(eshoot){
            eshoot = false;
            enemy.shoot(me.pos);
        }
        me.bulletsControl();
        enemy.bulletsControl();

        //衝突
        me.collision(enemy);
        enemy.collision(me);

        //生死判定
        if(me.isDie){
          isWin = false;
          mode = Mode.RESULT;
        }
        if(enemy.isDie){
          isWin = true;
          mode = Mode.RESULT;
        }

        //描画
        me.drawCharacter(t++);
        me.drawBullets();
        me.drawStatus();
        enemy.drawCharacter(t);
        enemy.drawBullets();

        //spの回復
        if(frameCount % 30 == 0){
            me.recovery(5);
            enemy.recovery(5);
        }
    }

    if(mode == Mode.RESULT){
      textSize(100);
      textAlign(CENTER);
      if(isWin){
        text("You WIN", 800, 450);
      }else{
        text("You LOSE", 800, 450);
      }

    }
}

void keyPressed() {
    if(mode == Mode.PLAY){
        if(key == 'w')
            cMovement.y = -1;
        if(key == 's')
            cMovement.y = 1;
        if(key == 'a')
            cMovement.x = -1;
        if(key == 'd')
            cMovement.x = 1;
    }
}

void keyReleased() {
    if(mode == Mode.PLAY){
        if(key == 'w')
            cMovement.y = 0;
        if(key == 's')
            cMovement.y = 0;
        if(key == 'a')
            cMovement.x = 0;
        if(key == 'd')
            cMovement.x = 0;
        if(key == 'j')
            cshoot = true;
    }
}

void mousePressed() {
    if(mode == Mode.READY){
        if(mouseButton == LEFT){
            if(mouseX >= 400 && mouseX <= 550 && mouseY >= 600 && mouseY <= 650){
                //サーバーに送信
                client.write("a" + " " + id.toString() +"\n");
                fill(#ffffff);
                textSize(45);
                selectedChapacter = "a";
            }
            if(mouseX >= 1050 && mouseX <= 1200 && mouseY >= 600 && mouseY <= 650 ){
                //サーバーに送信
                client.write("b" + " " + id.toString() +"\n");
                textSize(45);
                fill(#ffffff);
                selectedChapacter = "b";
            }
            
        }
    }
}
//serverから受け取ったら
//name horizontal vertical shoot(b) mouseX, mouseY
void clientEvent(Client client) {
  String s = client.readStringUntil('\n');
  if (s != null) {
    //分割
    String[] msg = splitTokens(s);
    if(mode == Mode.READY){
      if(msg.length == 5){
        //uuidの大小で位置決め大きいほうが左側
        //msg[0]のほうが大きい
        if((msg[0].compareTo(msg[2]) > 0)){
          //それが自分だったら
          if(msg[0].equals(id.toString())){
            me = new Character(100,100, new PVector(400,450), W, H, msg[1]);
            enemy = new Character(100, 100, new PVector(1200, 450), W, H, msg[3]);
            enemyName = msg[2]; 
            name = msg[0];
          }else{
            enemy = new Character(100,100, new PVector(400,450), W, H, msg[1]);
            me = new Character(100, 100, new PVector(1200, 450), W, H, msg[3]);
            enemyName = msg[0]; 
            name = msg[2];
          }
        }else{
          //msg[2]のほうが大きい
          if(msg[2].equals(id.toString())){
            me = new Character(100,100, new PVector(400,450), W, H, msg[3]);
            enemy = new Character(100, 100, new PVector(1200, 450), W, H, msg[1]);
            enemyName = msg[0]; 
            name = msg[2];
          }else{
            enemy = new Character(100,100, new PVector(400,450), W, H, msg[3]);
            me = new Character(100, 100, new PVector(1200, 450), W, H, msg[1]);
            enemyName = msg[2]; 
            name = msg[0];
          }
          
        }
        mode = Mode.PLAY;
      }
    }
    
    if(mode == Mode.PLAY){
      if(msg.length == 4){
        if(msg[0].equals(enemyName)){
          eMovement = new PVector(Float.parseFloat(msg[1]), Float.parseFloat(msg[2]));
          eshoot = msg[3].equals("true") ? true : false;
        }
      }
    }
  }
}
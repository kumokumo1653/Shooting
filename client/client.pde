import processing.net.*;
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
PVector cMouse = new PVector(0, 0);
PVector eMouse = new PVector(0, 0);
String name = "";
String enemyName = "";
boolean select = false;

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
}
void draw() {
    background(#000000);

    if(mode == Mode.READY){
        fill(#ffffff);
        rect(400, 600, 150, 50);
        textSize(70);
        textAlign(CENTER);
        text("Select Player", 800, 450);
        if(select){
          textSize(45);
          text("Already selected characters", 800, 550);
        }
        rect(1050, 600, 150, 50);
        fill(#000000);
        textSize(30);
        textAlign(LEFT);
        text("PlayerA", 420, 635);
        text("PlayerB", 1070, 635);

    }
    if(mode == Mode.PLAY){
        //サーバーに送信
        client.write(name + " " + cMovement.x + " " + cMovement.y + " " +  cshoot + " " + cMouse.x + " " + cMouse.y + '\n');
        me.move(cMovement);
        enemy.move(eMovement);

        if(cshoot){
            cshoot = false;
            me.shoot(cMouse);
        }
        if(eshoot){
            eshoot = false;
            enemy.shoot(eMouse);
        }
        me.bulletsControl();
        enemy.bulletsControl();

        //衝突
        me.collision(enemy);
        enemy.collision(me);

        //描画
        me.drawCharacter(t++);
        me.drawBullets();
        me.drawStatus();
        enemy.drawCharacter(t);
        enemy.drawBullets();

        //spの回復
        if(frameCount % 60 == 0){
            me.recovery(1);
            enemy.recovery(1);
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
    }
}

void mousePressed() {
    if(mode == Mode.PLAY){
        if(mouseButton == LEFT){
            cshoot = true;
            cMouse = new PVector(mouseX, mouseY);
        }
    }
    if(mode == Mode.READY){
        if(mouseButton == LEFT){
            if(mouseX >= 400 && mouseX <= 550 && mouseY >= 600 && mouseY <= 650){
              if(enemyName.equals("a")){
                select = true;
              }else{
                name = "a";
                enemyName = "b";
                mode = Mode.PLAY;
                me = new Character(100, 100, new PVector(800, 450), W, H);
                enemy = new Character(100,100, new PVector(100,100), W, H);
                //サーバーに送信
                client.write("a\n");
              }
            }
            if(mouseX >= 1050 && mouseX <= 1200 && mouseY >= 600 && mouseY <= 650 ){
              if(enemyName.equals("b")){
                select = true;
              }else{
                name = "b";
                enemyName = "a";
                mode = Mode.PLAY;
                enemy = new Character(100, 100, new PVector(800, 450), W, H);
                me = new Character(100,100, new PVector(100,100), W, H);
                //サーバーに送信
                client.write("b\n");
              }
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
      //character未設定のとき
      if(name.equals("")){
        enemyName = msg[0];
      }
    }
    if(mode == Mode.PLAY){
      if(msg.length == 6){
        if(msg[0].equals(enemyName)){
          eMovement = new PVector(Float.parseFloat(msg[1]), Float.parseFloat(msg[2]));
          eshoot = msg[3].equals("true") ? true : false;
          eMouse = new PVector(Float.parseFloat(msg[4]), Float.parseFloat(msg[5]));
        }
      }
    }
  }
}
Character me;
Character enemy;
int t;
PVector cMovement = new PVector(0,0);
PVector eMovement = new PVector(0,0);
int W = 1600;
int H = 900;
boolean cshoot = false;
boolean eshoot = false;

public enum Mode {
    READY,
    PLAY,
    RESULT
}
Mode mode;
void settings(){
    size(W, H);
}

void setup(){

    t = 0;
    
    mode = Mode.READY;

}

void draw(){
    background(#000000);
    if(mode == Mode.READY){
        fill(#ffffff);
        rect(400, 600, 150, 50);
        textSize(70);
        textAlign(CENTER);
        text("Select Player", 800, 450);
        rect(1050, 600, 150, 50);
        fill(#000000);
        textSize(30);
        textAlign(LEFT);
        text("PlayerA", 420, 635);
        text("PlayerB", 1070, 635);

    }
    if(mode == Mode.PLAY){
        me.move(cMovement);
        enemy.move(eMovement);

        if(cshoot){
            cshoot = false;
            me.shoot(new PVector(mouseX, mouseY));
        }
        if(eshoot){
            eshoot = false;
            enemy.shoot(new PVector(mouseX, mouseY));
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
        }
    }
    if(mode == Mode.READY){
        if(mouseButton == LEFT){
            if(mouseX >= 400 && mouseX <= 550 && mouseY >= 600 && mouseY <= 650){
                println("a");
                mode = Mode.PLAY;
                me = new Character(100, 100, new PVector(800, 450), W, H);
                enemy = new Character(100,100, new PVector(100,100), W, H);
            }
            if(mouseX >= 1050 && mouseX <= 1200 && mouseY >= 600 && mouseY <= 650 ){
                println("b");
                mode = Mode.PLAY;
                enemy = new Character(100, 100, new PVector(800, 450), W, H);
                me = new Character(100,100, new PVector(100,100), W, H);
            }
            
        }
    }
}

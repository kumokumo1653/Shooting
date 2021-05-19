Character c;
Character enemy;
int t;
PVector cMovement = new PVector(0,0);
PVector eMovement = new PVector(0,0);
int W = 1600;
int H = 900;
boolean cshoot = false;
boolean eshoot = false;

void settings(){
    size(W, H);
}
void setup(){

    c = new Character(100, 100, new PVector(800, 450), W, H);
    t = 0;

    enemy = new Character(100,100, new PVector(100,100), W, H);
    
}

void draw(){
    background(#000000);
    c.move(cMovement);
    enemy.move(eMovement);

    if(cshoot){
        cshoot = false;
        c.shoot(new PVector(mouseX, mouseY));
    }
    if(eshoot){
        eshoot = false;
        enemy.shoot(new PVector(mouseX, mouseY));
    }
    c.bulletsControl();
    enemy.bulletsControl();

    //衝突
    c.collision(enemy);
    enemy.collision(c);

    //描画
    c.drawCharacter(t++);
    c.drawBullets();
    c.drawStatus();
    enemy.drawCharacter(t);
    enemy.drawBullets();
}

void keyPressed() {
    if(key == 'w')
        cMovement.y = -1;
    if(key == 's')
        cMovement.y = 1;
    if(key == 'a')
        cMovement.x = -1;
    if(key == 'd')
        cMovement.x = 1;
    if(key == 'i')
        eMovement.y = -1;
    if(key == 'k')
        eMovement.y = 1;
    if(key == 'j')
        eMovement.x = -1;
    if(key == 'l')
        eMovement.x = 1;
}

void keyReleased() {
    if(key == 'w')
        cMovement.y = 0;
    if(key == 's')
        cMovement.y = 0;
    if(key == 'a')
        cMovement.x = 0;
    if(key == 'd')
        cMovement.x = 0;
    if(key == 'i')
        eMovement.y = 0;
    if(key == 'k')
        eMovement.y = 0;
    if(key == 'j')
        eMovement.x = 0;
    if(key == 'l')
        eMovement.x = 0;
}

void mousePressed() {
    if(mouseButton == LEFT){
        cshoot = true;
    }
    if(mouseButton == RIGHT){
        eshoot = true;
    }
}